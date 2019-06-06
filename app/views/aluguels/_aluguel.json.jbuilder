json.extract! aluguel, :id, :periodo, :data_vencimento, :previsao_pagamento, :valor_aluguel, :multa, :juros, :created_at, :updated_at
json.url aluguel_url(aluguel, format: :json)
