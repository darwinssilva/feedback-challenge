class Api::FeedbacksController < ApplicationController
  def index
    feedbacks = Feedback.all

    render json: feedbacks.select(
      :id, :employee_id, :data_resposta, :enps, :interesse_cargo, :contribuicao
    )
  end
end
