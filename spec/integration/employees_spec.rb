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

    post 'Create an employee' do
      tags 'Employees'
      consumes 'application/json'
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              nome: { type: :string },
              localidade: { type: :string },
              tempo_de_empresa: { type: :string },
              n0_empresa: { type: :string },
              n1_diretoria: { type: :string },
              n2_gerencia: { type: :string },
              n3_coordenacao: { type: :string },
              n4_area: { type: :string },
              faixa_etaria: { type: :string },
              genero: { type: :string },
              cargo: { type: :string },
              tipo_contrato: { type: :string },
              senioridade: { type: :string },
              turno: { type: :string }
            },
            required: [:nome, :localidade]
          }
        }
      }

      response '201', 'Employee created successfully' do
        let(:employee) do
          {
            employee: {
              nome: 'John Doe',
              localidade: 'São Paulo',
              tempo_de_empresa: '1 ano',
              n0_empresa: 'Empresa',
              n1_diretoria: 'Diretoria',
              n2_gerencia: 'Gerência',
              n3_coordenacao: 'Coordenação',
              n4_area: 'Área',
              faixa_etaria: '25-30',
              genero: 'Masculino',
              cargo: 'Desenvolvedor',
              tipo_contrato: 'CLT',
              senioridade: 'Pleno',
              turno: 'Diurno'
            }
          }
        end
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

    patch 'Update an employee' do
      tags 'Employees'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              nome: { type: :string }
            }
          }
        }
      }

      response '200', 'Employee updated' do
        let(:id) { create(:employee).id }
        let(:employee) { { employee: { nome: 'Updated Name' } } }
        run_test!
      end

      response '404', 'Employee not found' do
        let(:id) { 99999 }
        let(:employee) { { employee: { nome: 'Name' } } }
        run_test!
      end
    end

    delete 'Delete an employee' do
      tags 'Employees'
      parameter name: :id, in: :path, type: :integer

      response '204', 'Employee deleted' do
        let(:id) { create(:employee).id }
        run_test!
      end

      response '404', 'Employee not found' do
        let(:id) { 99999 }
        run_test!
      end
    end
  end
end
