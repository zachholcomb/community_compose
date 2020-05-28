class ScoresController < ApplicationController
  def index
    # @score = FlatService.get_score(params[:score_id])
    @score = Score.show(params[:score_id])
  end
end
