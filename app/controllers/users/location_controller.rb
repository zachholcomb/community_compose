class Users::LocationController < ApplicationController
  def edit
    failure if !user_permitted?
    @user = User.find(params[:id])
  end

  def update
    User.update(params[:id], user_params)
    flash_and_redirect
  end

  private

  def user_params
    params.permit(:zip)
  end

  def failure
    render file: '/public/404'
  end

  def flash_and_redirect
    flash[:notice] = 'Successfully updated location!'
    redirect_to user_path(params[:id])
  end
end
