class DashboardFacade
  attr_reader :user_info, :scores

  def initialize(current_user)
    @user_info = FlatService.get_user(current_user)
    @scores = FlatService.get_scores(current_user)
  end

end
