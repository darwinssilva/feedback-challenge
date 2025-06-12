require 'swagger_helper'

RSpec.describe 'API:Feedback', type: :request do
  path '/api/feedback' do
    get 'List feedback (with filters and pagination)' do
      tags 'Feedback'
      produces 'application/json'

      parameter name: :employee_id, in: :query, type: :integer, required: false, description: 'Filter by employee ID'
      parameter name: :page, in: :query, type: :integer, required: false, description: 'Page number'
      parameter name: :per_page, in: :query, type: :integer, required: false, description: 'Items per page'

      response '200', 'Feedback successfully listed' do
        run_test!
      end
    end
  end

  path '/api/feedback/{id}' do
    get 'Get feedback details' do
      tags 'Feedback'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true, description: 'Feedback ID'

      response '200', 'Feedback found' do
        let(:id) { create(:feedback).id }
        run_test!
      end

      response '404', 'Feedback not found' do
        let(:id) { 9999 }
        run_test!
      end
    end
  end
end