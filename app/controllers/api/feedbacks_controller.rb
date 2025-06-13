class Api::FeedbacksController < Api::ApplicationController
  before_action :set_feedback, only: %i[show update destroy]

  def index
    feedbacks = Feedback.filtered(params).page(params[:page]).per(params[:per_page])
    render json: feedbacks
  end

  def show
    render json: @feedback
  end

  def create
    feedback = Feedback.new(feedback_params)
    if feedback.save
      render json: feedback, status: :created
    else
      render json: { errors: feedback.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @feedback.update(feedback_params)
      render json: @feedback
    else
      render json: { errors: @feedback.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @feedback.destroy
    head :no_content
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Feedback not found' }, status: :not_found
  end

  def feedback_params
    params.require(:feedback).permit(
      :employee_id,
      :data_resposta,
      :interesse_cargo,
      :comentario_interesse,
      :contribuicao,
      :comentario_contribuicao,
      :aprendizado_desenvolvimento,
      :comentario_aprendizado_desenvolvimento,
      :feedback,
      :comentario_feedback,
      :interacao_gestor,
      :comentario_interacao_gestor,
      :clareza_carreira,
      :comentario_clareza_carreira,
      :expectativa_permanencia,
      :comentario_expectativa,
      :enps,
      :enps_aberto,
      :comentario_enps
    )
  end
end
