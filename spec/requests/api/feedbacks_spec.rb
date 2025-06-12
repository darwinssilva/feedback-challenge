require 'rails_helper'

RSpec.describe "API::Feedbacks", type: :request do
  let!(:employee1) { create(:employee) }
  let!(:employee2) { create(:employee) }

  let!(:feedback1) do
    create(:feedback, employee: employee1, enps: 7, data_resposta: Date.new(2022, 2, 1))
  end

  let!(:feedback2) do
    create(:feedback, employee: employee1, enps: 8, data_resposta: Date.new(2022, 2, 1))
  end

  let!(:feedback3) do
    create(:feedback, employee: employee2, enps: 5, data_resposta: Date.new(2022, 3, 1))
  end

  describe "GET /api/feedbacks" do
    it "retorna todos os feedbacks" do
      get "/api/feedbacks"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(3)
    end

    it "filtra por employee_id" do
      get "/api/feedbacks", params: { employee_id: employee1.id }
      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
      expect(json.all? { |f| f["employee_id"] == employee1.id }).to be true
    end

    it "filtra por data_resposta" do
      get "/api/feedbacks", params: { data_resposta: "2022-03-01" }
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
      expect(json.first["employee_id"]).to eq(employee2.id)
    end

    it "filtra por employee_id e data_resposta" do
      get "/api/feedbacks", params: { employee_id: employee1.id, data_resposta: "2022-02-01" }
      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
    end
  end
end
