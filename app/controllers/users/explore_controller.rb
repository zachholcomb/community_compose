class Users::ExploreController < ApplicationController
  def index
    @explore_data = ExploreFacade.new(current_user)
  end
end
