class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.references :employee, null: false, foreign_key: true
      t.date :data_resposta
      t.integer :interesse_cargo
      t.text :comentario_interesse
      t.integer :contribuicao
      t.text :comentario_contribuicao
      t.integer :aprendizado_desenvolvimento
      t.text :comentario_aprendizado
      t.integer :feedback
      t.text :comentario_feedback
      t.integer :interacao_gestor
      t.text :comentario_interacao
      t.integer :clareza_carreira
      t.text :comentario_clareza
      t.integer :expectativa_permanencia
      t.text :comentario_expectativa
      t.integer :enps
      t.text :comentario_enps

      t.timestamps
    end
  end
end
