class ScoresController < ApplicationController
  def index
    @score = Score.show(params[:score_id])
    @score_bank = ScoreFacade.new
  end

  def new; end

  def create
    score = Score.new_score(params[:title], params[:clef])
    redirect_to "/scores?score_id=#{score[:id]}"
  end

  def update
    respond_to do |format|
      format.js { flash.now[:notice] = 'Your changes were submitted!'}
    end
  end

  def destroy
    Score.delete(params[:id])
    redirect_to users_dashboard_index_path
  end
end
