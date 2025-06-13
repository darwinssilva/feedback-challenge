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

  describe "GET /api/feedbacks/:id" do
    it "retorna os dados de um feedback específico" do
      get "/api/feedbacks/#{feedback1.id}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(feedback1.id)
      expect(json["employee_id"]).to eq(employee1.id)
    end

    it "retorna 404 se o feedback não existe" do
      get "/api/feedbacks/99999"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/feedbacks" do
    it "cria um novo feedback" do
      params = {
        feedback: {
          employee_id: employee1.id,
          data_resposta: "2025-06-13",
          interesse_cargo: 5,
          comentarios_interesse_cargo: "Interessado",
          contribuicao: 6,
          comentarios_contribuicao: "Contribui bem",
          aprendizado_desenvolvimento: 7,
          comentarios_aprendizado_desenvolvimento: "Aprendendo rápido",
          feedback: 6,
          comentario_expectativa: "Bom ambiente",
          interacao_gestor: 6,
          comentarios_interacao_gestor: "Gestor acessível",
          clareza_carreira: 4,
          comentarios_clareza_carreira: "Precisa de mais clareza",
          expectativa_permanencia: 5,
          enps: 9,
          comentario_enps: "Recomendaria"
        }
      }

      post "/api/feedbacks", params: params
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["employee_id"]).to eq(employee1.id)
      expect(json["comentario_expectativa"]).to eq("Bom ambiente")
    end

    it "retorna erro se os dados forem inválidos" do
      post "/api/feedbacks", params: { feedback: { employee_id: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /api/feedbacks/:id" do
    it "atualiza um feedback existente" do
      patch "/api/feedbacks/#{feedback1.id}", params: { feedback: { comentario_enps: "Atualizado" } }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["comentario_enps"]).to eq("Atualizado")
    end

    it "retorna 404 se o feedback não existe" do
      patch "/api/feedbacks/99999", params: { feedback: { comentario_enps: "Teste" } }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/feedbacks/:id" do
    it "remove um feedback existente" do
      delete "/api/feedbacks/#{feedback3.id}"
      expect(response).to have_http_status(:no_content)
      expect(Feedback.exists?(feedback3.id)).to be_falsey
    end

    it "retorna 404 se o feedback não existe" do
      delete "/api/feedbacks/99999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
