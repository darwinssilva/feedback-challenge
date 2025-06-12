require 'rails_helper'

RSpec.describe "API::Feedbacks", type: :request do
  let!(:employee) { create(:employee) }
  let!(:feedbacks) { create_list(:feedback, 3, employee: employee) }

  describe "GET /api/feedbacks" do
    it "retorna todos os feedbacks" do
      get "/api/feedbacks"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end

    it "filtra feedbacks por employee_id" do
      get "/api/feedbacks", params: { employee_id: employee.id }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.all? { |f| f["employee_id"] == employee.id }).to be true
    end
  end
end
