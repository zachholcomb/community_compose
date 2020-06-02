class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new(flat_id: params[:flat_id])
  end

  def create
    user = User.create(user_params)
    session[:user_id] = user.id
    redirect_to users_dashboard_index_path
  end

  private

  def user_params
    {
      email: params[:user][:email],
      zip: params[:user][:zip],
      flat_id: params[:flat_id],
      username: FlatService.get_user[:username]
    }
  end
end
