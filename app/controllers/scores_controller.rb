class ScoresController < ApplicationController
  def index
    FlatService.flat_key = current_user.flat_key
    @score = Score.show(params[:score_id])
  end

  def new; end

  def create
    FlatService.flat_key = current_user.flat_key
    Score.new_score(params[:title])
    redirect_to users_dashboard_index_path
  end

  def update
    flash[:notice] = 'Your changes were saved!'
    redirect_to users_dashboard_index_path
  end

  def destroy
    FlatService.flat_key = current_user.flat_key
    Score.delete(params[:id])
    redirect_to users_dashboard_index_path
  end
end
