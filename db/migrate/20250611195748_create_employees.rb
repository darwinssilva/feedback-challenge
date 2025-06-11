class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :nome
      t.string :email
      t.string :email_corporativo
      t.string :area
      t.string :cargo
      t.string :funcao
      t.string :localidade
      t.string :tempo_de_empresa
      t.string :genero
      t.string :geracao
      t.string :n0_empresa
      t.string :n1_diretoria
      t.string :n2_gerencia
      t.string :n3_coordenacao
      t.string :n4_area

      t.timestamps
    end
  end
end
