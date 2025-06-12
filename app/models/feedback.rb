class Feedback < ApplicationRecord
  belongs_to :employee

  scope :by_employee, ->(id) { where(employee_id: id) }
  scope :by_data, ->(date) { where(data_resposta: date) }

  def self.filtered(params)
    feedbacks = all
    feedbacks = feedbacks.by_employee(params[:employee_id]) if params[:employee_id]
    feedbacks = feedbacks.by_data(params[:data_resposta]) if params[:data_resposta]
    feedbacks
  end
end
