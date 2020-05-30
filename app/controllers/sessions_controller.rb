class SessionsController < ApplicationController
  def new;  end

  def create
    user = User.find_by(email: 'user@example.com')
    session[:user_id] = user.id
    redirect_to users_dashboard_index_path
  end
end
