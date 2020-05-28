class Users::DashboardController < ApplicationController
  def index
    @user = DashboardFacade.new(current_user)
  end
end
