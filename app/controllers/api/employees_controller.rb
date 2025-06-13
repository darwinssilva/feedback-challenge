class Api::EmployeesController < Api::ApplicationController
  before_action :set_employee, only: %i[show update destroy]

  def index
    employees = Employee.filtered(params).page(params[:page]).per(params[:per_page])
    render json: employees
  end

  def show
    employee = Employee.find(params[:id])
    render json: employee.as_json.merge(
      feedbacks: employee.feedbacks.select(:id, :data_resposta, :enps, :interesse_cargo, :contribuicao)
    )
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Employee not found' }, status: :not_found
  end

  def employee_params
    params.require(:employee).permit(:nome, :email, :email_corporativo, :area, :cargo, :funcao, :localidade, :tempo_de_empresa, :genero, :geracao, :n0_empresa, :n1_diretoria, :n2_gerencia, :n3_coordenacao, :n4_area)
  end
end
