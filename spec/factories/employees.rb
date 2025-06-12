FactoryBot.define do
  factory :employee do
    nome { "Funcionário Teste" }
    email { Faker::Internet.unique.email }
    email_corporativo { Faker::Internet.unique.email }
    area { "TI" }
    cargo { "Analista" }
    funcao { "Profissional" }
    localidade { "São Paulo" }
    tempo_de_empresa { "entre 1 e 2 anos" }
    genero { "masculino" }
    geracao { "geração z" }
    n0_empresa { "empresa" }
    n1_diretoria { "diretoria a" }
    n2_gerencia { "gerência a1" }
    n3_coordenacao { "coordenação a11" }
    n4_area { "área a112" }
  end
end
