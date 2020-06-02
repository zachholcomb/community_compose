class Users::DashboardController < ApplicationController
  def index
    @flat_user = DashboardFacade.new
  end
end
