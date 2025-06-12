require 'swagger_helper'

RSpec.describe 'API::Employees', type: :request do
  path '/api/employees' do
    get 'List employees (with filters and pagination)' do
      tags 'Employees'
      produces 'application/json'

      parameter name: :location, in: :query, type: :string, required: false, description: 'Filter by location'
      parameter name: :area, in: :query, type: :string, required: false, description: 'Filter by department'
      parameter name: :time_at_company, in: :query, type: :string, required: false, description: 'Filter by time at company'
      parameter name: :page, in: :query, type: :integer, required: false, description: 'Page number'
      parameter name: :per_page, in: :query, type: :integer, required: false, description: 'Items per page'

      response '200', 'Employees successfully listed' do
        run_test!
      end
    end
  end

  path '/api/employees/{id}' do
    get 'Get employee details' do
      tags 'Employees'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true, description: 'Employee ID'

      response '200', 'Employee found' do
        let(:id) { create(:employee).id }
        run_test!
      end

      response '404', 'Employee not found' do
        let(:id) { 9999 }
        run_test!
      end
    end
  end
end
