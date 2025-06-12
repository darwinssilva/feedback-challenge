class Api::EmployeesController < ApplicationController
  def index
    employees = Employee.filtered(params)
                      .select(:id, :nome, :email, :area, :cargo, :localidade)
                      .page(params[:page])
                      .per(params[:per_page] || 10)

    render json: {
      data: employees,
      meta: {
        current_page: employees.current_page,
        total_pages: employees.total_pages,
        total_count: employees.total_count
      }
    }
  end

  def show
    employee = Employee.includes(:feedbacks).find(params[:id])
    render json: employee.as_json(
      except: [:created_at, :updated_at],
      include: {
        feedbacks: {
          except: [:created_at, :updated_at, :employee_id]
        }
      }
    )
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Funcionário não encontrado' }, status: :not_found
  end
end
