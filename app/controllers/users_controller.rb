class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    failure if !user_permitted?
    @user = User.find(params[:id])
  end

  def update
    user_id = User.find(params[:id]).id
    User.update(user_id, user_params)
    redirect_to user_path(user_id)
  end

  private

  def user_params
    params.permit(:username)
  end

  def failure
    render file: '/public/404'
  end
end
