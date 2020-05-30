class RequestsController < ApplicationController

  def create
    Request.create(score: request_params[:score_id],
                   username: request_params[:username])
    redirect_to scores_path(:params => {score_id: request_params[:score_id]})
  end

  def destroy
    Request.delete(request_params[:id].to_i)
    redirect_to scores_path(:params => {score_id: request_params[:score_id]})
  end

  private

  def request_params
    params.permit(:id, :username, :score_id, :type)
  end
end
