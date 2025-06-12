class Api::EmployeesController < ApplicationController
  def index
    employees = Employee.select(:id, :nome, :email, :area, :cargo, :localidade)
    render json: employees
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
    render json: { error: 'Employee not found' }, status: :not_found
  end
end
