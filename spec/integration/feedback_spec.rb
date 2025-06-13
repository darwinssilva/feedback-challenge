require 'swagger_helper'

RSpec.describe 'API::Feedbacks', type: :request do
  path '/api/feedbacks' do
    get 'List feedbacks (with optional filters and pagination)' do
      tags 'Feedbacks'
      produces 'application/json'

      parameter name: :employee_id, in: :query, type: :integer, required: false, description: 'Filter by employee ID'
      parameter name: :data_resposta, in: :query, type: :string, required: false, description: 'Filter by response date (YYYY-MM-DD)'
      parameter name: :page, in: :query, type: :integer, required: false, description: 'Page number'
      parameter name: :per_page, in: :query, type: :integer, required: false, description: 'Items per page'

      response '200', 'Feedbacks successfully listed' do
        let(:employee) { create(:employee) }
        let(:employee_id) { employee.id }
        let(:data_resposta) { '2022-02-01' }
        let(:page) { 1 }
        let(:per_page) { 10 }

        run_test!
      end
    end

    post 'Create a new feedback' do
      tags 'Feedbacks'
      consumes 'application/json'

      parameter name: :feedback, in: :body, schema: {
        type: :object,
        properties: {
          feedback: {
            type: :object,
            properties: {
              employee_id: { type: :integer },
              data_resposta: { type: :string, format: :date },
              interesse_cargo: { type: :integer },
              comentarios_interesse_cargo: { type: :string },
              contribuicao: { type: :integer },
              comentarios_contribuicao: { type: :string },
              aprendizado_desenvolvimento: { type: :integer },
              comentarios_aprendizado_desenvolvimento: { type: :string },
              feedback: { type: :integer },
              comentario_expectativa: { type: :string },
              interacao_gestor: { type: :integer },
              comentarios_interacao_gestor: { type: :string },
              clareza_carreira: { type: :integer },
              comentarios_clareza_carreira: { type: :string },
              expectativa_permanencia: { type: :integer },
              comentario_expectativa: { type: :string },
              enps: { type: :integer },
            },
            required: [:employee_id, :data_resposta]
          }
        }
      }

      response '201', 'Feedback successfully created' do
        let(:employee) { create(:employee) }
        let(:feedback) do
          {
            feedback: {
              employee_id: employee.id,
              data_resposta: '2025-06-13',
              interesse_cargo: 5,
              comentarios_interesse_cargo: 'Interested',
              contribuicao: 6,
              comentarios_contribuicao: 'Contribute well',
              aprendizado_desenvolvimento: 7,
              comentarios_aprendizado_desenvolvimento: 'Learning fast',
              feedback: 6,
              comentario_expectativa: 'Good team',
              interacao_gestor: 6,
              comentarios_interacao_gestor: 'Supportive manager',
              clareza_carreira: 4,
              comentarios_clareza_carreira: 'Need more clarity',
              expectativa_permanencia: 5,
              comentario_expectativa: 'Planning to stay',
              enps: 9,
              comentarios_enps: 'Would recommend'
            }
          }
        end
        run_test!
      end

      response '422', 'Invalid data' do
        let(:feedback) { { feedback: { employee_id: nil } } }
        run_test!
      end
    end
  end

  path '/api/feedbacks/{id}' do
    get 'Get feedback details' do
      tags 'Feedbacks'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true, description: 'Feedback ID'

      response '200', 'Feedback found' do
        let(:id) { create(:feedback).id }
        run_test!
      end

      response '404', 'Feedback not found' do
        let(:id) { 99999 }
        run_test!
      end
    end

    patch 'Update a feedback' do
      tags 'Feedbacks'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :feedback, in: :body, schema: {
        type: :object,
        properties: {
          feedback: {
            type: :object,
            properties: {
              comentarios_enps: { type: :string }
            }
          }
        }
      }

      response '200', 'Feedback updated' do
        let(:employee) { create(:employee) }
        let(:id) { create(:feedback, employee: employee).id }
        let(:feedback) { { feedback: { comentarios_enps: 'Updated comment' } } }
        run_test!
      end

      response '404', 'Feedback not found' do
        let(:id) { 99999 }
        let(:feedback) { { feedback: { comentarios_enps: 'Test' } } }
        run_test!
      end
    end

    delete 'Delete a feedback' do
      tags 'Feedbacks'
      parameter name: :id, in: :path, type: :integer, required: true

      response '204', 'Feedback deleted' do
        let(:employee) { create(:employee) }
        let(:id) { create(:feedback, employee: employee).id }
        run_test!
      end

      response '404', 'Feedback not found' do
        let(:id) { 99999 }
        run_test!
      end
    end
  end
end
