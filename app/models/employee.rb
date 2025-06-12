class Employee < ApplicationRecord
  has_many :feedbacks, dependent: :destroy

  scope :by_localidade, ->(value) { where(localidade: value) }
  scope :by_area, ->(value) { where(area: value) }
  scope :by_tempo, ->(value) { where(tempo_de_empresa: value) }

  def self.filtered(params)
    employees = all
    employees = employees.by_localidade(params[:localidade]) if params[:localidade].present?
    employees = employees.by_area(params[:area]) if params[:area].present?
    employees = employees.by_tempo(params[:tempo_de_empresa]) if params[:tempo_de_empresa].present?
    employees
  end
end
