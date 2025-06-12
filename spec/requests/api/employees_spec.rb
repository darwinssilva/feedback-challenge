require 'rails_helper'

RSpec.describe "API::Employees", type: :request do
  let!(:employee1) { create(:employee, nome: "Alice", localidade: "recife", area: "TI", tempo_de_empresa: "entre 1 e 2 anos") }
  let!(:employee2) { create(:employee, nome: "Bob", localidade: "brasília", area: "RH", tempo_de_empresa: "menos de 1 ano") }
  let!(:employee3) { create(:employee, nome: "Carol", localidade: "recife", area: "TI", tempo_de_empresa: "entre 2 e 5 anos") }

  describe "GET /api/employees" do
    it "retorna todos os funcionários" do
      get "/api/employees"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end

    it "filtra por localidade" do
      get "/api/employees", params: { localidade: "recife" }
      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
      expect(json.all? { |e| e["localidade"] == "recife" }).to be true
    end

    it "filtra por área" do
      get "/api/employees", params: { area: "RH" }
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
      expect(json.first["nome"]).to eq("Bob")
    end

    it "filtra por tempo de empresa" do
      get "/api/employees", params: { tempo_de_empresa: "entre 2 e 5 anos" }
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
      expect(json.first["nome"]).to eq("Carol")
    end

    it "combina múltiplos filtros" do
      get "/api/employees", params: { area: "TI", localidade: "recife" }
      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
    end
  end

  describe "GET /api/employees/:id" do
    it "retorna os dados de um funcionário com feedbacks" do
      create(:feedback, employee: employee1, enps: 8)
      get "/api/employees/#{employee1.id}"
      json = JSON.parse(response.body)
      expect(json["nome"]).to eq("Alice")
      expect(json["feedbacks"]).to be_an(Array)
      expect(json["feedbacks"].first["enps"]).to eq(8)
    end

    it "retorna 404 se funcionário não existe" do
      get "/api/employees/9999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
