require 'google/api_client'
require 'google_drive'

class CommissionerController < ApplicationController
  before_filter :authenticate_user!
  force_ssl unless Rails.env.development?

  def index
    redirect_to root_url unless current_user.admin || current_user.commissioner
  end

  def auth
    redirect_to root_url unless current_user.admin || current_user.commissioner
    if session[:google_access_token].blank? || session[:google_token_date].blank? || Time.now > Time.parse(session[:google_token_date])
      client = Google::APIClient.new
      auth = client.authorization
      auth.update!(
          client_id: ENV['GOOGLE_CLIENT_ID'],
          client_secret: ENV['GOOGLE_CLIENT_SECRET'],
          grant_type: "authorization_code",
          scope: "https://www.googleapis.com/auth/drive ",
          redirect_uri: authenticate_commissioner_url
      )
      if params['code'].blank?
        auth_url = auth.authorization_uri.to_s
        redirect_to auth_url
      else
        auth.code = request['code']
        auth.fetch_access_token!
        session[:google_access_token] = auth.access_token
        session[:google_token_date] = Time.now.advance(hours: 1).to_s
        Resque.enqueue(ExportData, auth.access_token, 1)
      end
    else
      Resque.enqueue(ExportData, session[:google_access_token], 1)
    end
  end
end
