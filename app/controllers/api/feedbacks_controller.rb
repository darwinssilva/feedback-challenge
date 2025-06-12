class Api::FeedbacksController < ApplicationController
  def index
    feedbacks = Feedback.all

    if params[:employee_id]
      feedbacks = feedbacks.where(employee_id: params[:employee_id])
    end

    render json: feedbacks.select(
      :id, :employee_id, :data_resposta, :enps, :interesse_cargo, :contribuicao
    )
  end
end
