class Users::DashboardController < ApplicationController
  def index
    FlatService.flat_key = current_user.flat_key
    @user = DashboardFacade.new
  end
end
