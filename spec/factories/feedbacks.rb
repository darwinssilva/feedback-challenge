FactoryBot.define do
  factory :feedback do
    employee
    data_resposta { Date.today }
    interesse_cargo { rand(1..10) }
    comentario_interesse { nil }
    contribuicao { rand(1..10) }
    comentario_contribuicao { nil }
    aprendizado_desenvolvimento { rand(1..10) }
    comentario_aprendizado { nil }
    feedback { rand(1..10) }
    comentario_feedback { nil }
    interacao_gestor { rand(1..10) }
    comentario_interacao { nil }
    clareza_carreira { rand(1..10) }
    comentario_clareza { nil }
    expectativa_permanencia { rand(1..10) }
    comentario_expectativa { nil }
    enps { rand(0..10) }
    comentario_enps { nil }
  end
end
