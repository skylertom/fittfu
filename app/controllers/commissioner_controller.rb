require 'google/api_client'
require 'google_drive'

class CommissionerController < ApplicationController
  before_filter :authenticate_user!
  force_ssl unless Rails.env.development?

  def index
    redirect_to root_url unless current_user.admin || current_user.commissioner
  end

  def get_players
    # TODO better check for over calling
    if Player.exists?
      # tell commissioner you already have players
    else
      key = auth(get_players_url)
      if !key.blank?
        GetPlayers.from_google(key)
        redirect_to teams_path
      end
    end
  end

  def load_stats
    # TODO safeguard against overcalling
    key = auth(load_stats_url)
    if !key.blank?
      GetPlayersStats.from_google(key)
      redirect_to games_path(params: {time: "all"})
    end
  end

  def auth(redirect_url)
    if session[:google_access_token].blank? || session[:google_token_date].blank? || DateTime.now > DateTime.parse(session[:google_token_date])
      client = Google::APIClient.new
      auth = client.authorization
      auth.update!(
          client_id: ENV['GOOGLE_CLIENT_ID'],
          client_secret: ENV['GOOGLE_CLIENT_SECRET'],
          grant_type: "authorization_code",
          scope: "https://www.googleapis.com/auth/drive ",
          redirect_uri: redirect_url
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
