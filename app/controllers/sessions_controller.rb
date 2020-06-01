require 'uri'
class SessionsController < ApplicationController
  def new; end

  def create
    data = {
      grant_type: 'authorization_code',
      code: params[:code],
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      redirect_uri: "http://localhost:3000/auth/flat/callback"
    }
    response = Faraday.post("https://api.flat.io/oauth/access_token") do |resp|
      resp.headers['content-type'] = 'application/x-www-form-urlencoded'
      resp.body = URI.encode_www_form(data)
    end
    body = JSON.parse(response.body, symbolize_names: true)
    FlatService.flat_key = body[:access_token]
    user = User.find_by(flat_id: body[:user])
    return redirect_to new_user_path(params: {flat_id: body[:user]}) if user.nil?
    session[:user_id] = user.id
    redirect_to users_dashboard_index_path

    # user = User.find_by(email: params[:session][:email])
    # session[:user_id] = user.id
    # redirect_to users_dashboard_index_path
  end
end
