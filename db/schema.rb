# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_06_11_195754) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "email_corporativo"
    t.string "area"
    t.string "cargo"
    t.string "funcao"
    t.string "localidade"
    t.string "tempo_de_empresa"
    t.string "genero"
    t.string "geracao"
    t.string "n0_empresa"
    t.string "n1_diretoria"
    t.string "n2_gerencia"
    t.string "n3_coordenacao"
    t.string "n4_area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.date "data_resposta"
    t.integer "interesse_cargo"
    t.text "comentario_interesse"
    t.integer "contribuicao"
    t.text "comentario_contribuicao"
    t.integer "aprendizado_desenvolvimento"
    t.text "comentario_aprendizado"
    t.integer "feedback"
    t.text "comentario_feedback"
    t.integer "interacao_gestor"
    t.text "comentario_interacao"
    t.integer "clareza_carreira"
    t.text "comentario_clareza"
    t.integer "expectativa_permanencia"
    t.text "comentario_expectativa"
    t.integer "enps"
    t.text "comentario_enps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_feedbacks_on_employee_id"
  end

  add_foreign_key "feedbacks", "employees"
end
