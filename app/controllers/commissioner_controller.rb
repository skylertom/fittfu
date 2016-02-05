require "google/api_client"
require "google_drive"

class CommissionerController < ApplicationController
  before_filter :authenticate_user!

  def index
    redirect_to root_url unless current_user.admin || current_user.commissioner
  end

  def auth
    redirect_to root_url unless current_user.admin || current_user.commissioner
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
      #save token! (in redis?)

      OutputWeek.write(auth.access_token, 2)
    end
  end
end
