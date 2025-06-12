class Api::FeedbacksController < ApplicationController
  def index
    feedbacks = Feedback.filtered(params)
                      .select(:id, :employee_id, :data_resposta, :enps, :interesse_cargo, :contribuicao)
                      .page(params[:page])
                      .per(params[:per_page] || 10)

    render json: {
      data: feedbacks,
      meta: {
        current_page: feedbacks.current_page,
        total_pages: feedbacks.total_pages,
        total_count: feedbacks.total_count
      }
    }
  end
end
