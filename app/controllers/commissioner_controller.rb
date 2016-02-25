require 'google/api_client'
require 'google_drive'

class CommissionerController < ApplicationController
  before_filter :authenticate_user!
  force_ssl unless Rails.env.development?

  def index
    redirect_to root_url unless current_user.admin || current_user.commissioner
  end

  def get_players
    if Player.exists?
      flash[:alert] = "There are already players in the system"
      redirect_to :back
    else
      key = auth(get_players_url, nil)
      if !key.blank?
        initial = Player.all.size
        GetPlayers.from_google(key)
        flash[:success] = "Added #{Player.all.size - initial} players to the database"
        redirect_to commissioner_index_path
      end
    end
  end

  def load_stats
    if GameStat.where(week: 0).where('created_at < updated_at').exists?
      flash[:alert] = "There are already stats for the first week"
      redirect_to :back
      return
    end
    key = auth(load_stats_url, nil)
    if !key.blank?
      GetPlayersStats.from_google(key)
      flash[:success] = "Loaded Players Stats"
      redirect_to commissioner_index_path
    end
  end

  def export_week
    key = auth(export_week_url, params[:week])
    if !key.blank?
      week = params[:week] || params[:state]
      ExportData.perform_async(key, week.to_i)
      flash[:alert] = "Exporting week #{week.to_i + 1} in background, feel free to keep using the website"
      redirect_to commissioner_index_path
    end
  end

  private

  def auth(redirect_url, state)
    if session[:google_access_token].blank? || session[:google_token_date].blank? || DateTime.now > DateTime.parse(session[:google_token_date])
      client = Google::APIClient.new
      auth = client.authorization
      auth.update!(
          client_id: ENV['GOOGLE_CLIENT_ID'],
          client_secret: ENV['GOOGLE_CLIENT_SECRET'],
          grant_type: "authorization_code",
          scope: "https://www.googleapis.com/auth/drive ",
          redirect_uri: redirect_url,
          state: state
      )
      if params['code'].blank?
        auth_url = auth.authorization_uri.to_s
        redirect_to auth_url
        ""
      else
        auth.code = request['code']
        auth.fetch_access_token!
        session[:google_access_token] = auth.access_token
        session[:google_token_date] = DateTime.now.advance(hours: 1).to_s
        return auth.access_token
      end
    else
      p "Already have token"
      return session[:google_access_token]
    end
  end
end
