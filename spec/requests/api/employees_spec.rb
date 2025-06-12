require 'rails_helper'

RSpec.describe "API::Employees", type: :request do
  let!(:employee) { create(:employee, nome: "João") }
  let!(:feedback) { create(:feedback, employee: employee, enps: 9) }

  describe "GET /api/employees" do
    it "retorna todos os funcionários" do
      get "/api/employees"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an(Array)
    end
  end

  describe "GET /api/employees/:id" do
    it "retorna os dados de um funcionário com feedbacks" do
      get "/api/employees/#{employee.id}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["nome"]).to eq("João")
      expect(json["feedbacks"]).to be_an(Array)
    end

    it "retorna 404 se funcionário não existir" do
      get "/api/employees/9999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
