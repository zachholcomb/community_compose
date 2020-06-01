class RequestsController < ApplicationController
  def create
    Request.create(score: request_params[:score_id],
                   username: request_params[:username])
    flash[:notice] = 'Request to collaborate submitted'
    redirect_to scores_path(params: { score_id: request_params[:score_id] })
  end

  def destroy
    if request_params[:type] == 'approve'
      user = User.find_by(username: request_params[:username])
      Score.add_collaborator(request_params[:score_id], user[:flat_id])
    end

    Request.delete(request_params[:id].to_i)
    redirect_to scores_path(params: { score_id: request_params[:score_id] })
  end

  private

  def request_params
    params.permit(:id, :username, :score_id, :type)
  end
end
