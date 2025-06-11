require 'csv'

filepath = Rails.root.join('db/csv/data.csv')

CSV.foreach(filepath, headers: true, col_sep: ';') do |row|
  employee = Employee.create!(
    nome: row['nome'],
    email: row['email'],
    email_corporativo: row['email_corporativo'],
    area: row['area'],
    cargo: row['cargo'],
    funcao: row['funcao'],
    localidade: row['localidade'],
    tempo_de_empresa: row['tempo_de_empresa'],
    genero: row['genero'],
    geracao: row['geracao'],
    n0_empresa: row['n0_empresa'],
    n1_diretoria: row['n1_diretoria'],
    n2_gerencia: row['n2_gerencia'],
    n3_coordenacao: row['n3_coordenacao'],
    n4_area: row['n4_area']
  )

  Feedback.create!(
    employee: employee,
    data_resposta: Date.strptime(row['Data da Resposta'], "%d/%m/%Y"),
    interesse_cargo: row['Interesse no Cargo'],
    comentario_interesse: row['Comentários - Interesse no Cargo'],
    contribuicao: row['Contribuição'],
    comentario_contribuicao: row['Comentários - Contribuição'],
    aprendizado_desenvolvimento: row['Aprendizado e Desenvolvimento'],
    comentario_aprendizado: row['Comentários - Aprendizado e Desenvolvimento'],
    feedback: row['Feedback'],
    comentario_feedback: row['Comentários - Feedback'],
    interacao_gestor: row['Interação com Gestor'],
    comentario_interacao: row['Comentários - Interação com Gestor'],
    clareza_carreira: row['Clareza sobre Possibilidades de Carreira'],
    comentario_clareza: row['Comentários - Clareza sobre Possibilidades de Carreira'],
    expectativa_permanencia: row['Expectativa de Permanência'],
    comentario_expectativa: row['Comentários - Expectativa de Permanência'],
    enps: row['eNPS'],
    comentario_enps: row['[Aberta] eNPS']
  )
end
