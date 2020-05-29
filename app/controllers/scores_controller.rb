class ScoresController < ApplicationController
  def index
    @score = Score.show(params[:score_id])
  end

  def new; end

  def create
    Score.new_score(params[:title])
    redirect_to users_dashboard_index_path
  end

  def destroy
    Score.delete(params[:id])
    redirect_to users_dashboard_index_path
  end
end
