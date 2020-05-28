class DashboardFacade
  attr_reader :user_info, :scores

  def initialize
    @user_info = FlatService.get_user
    @scores = FlatService.get_scores
  end

end
