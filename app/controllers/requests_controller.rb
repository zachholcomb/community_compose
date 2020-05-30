class RequestsController < ApplicationController

  def create
    Request.create(score: request_params[:score_id],
                   username: request_params[:username])
    redirect_to scores_path(:params => {score_id: request_params[:score_id]})
  end

  private

  def request_params
    params.permit(:username, :score_id)
  end
end
