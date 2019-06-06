json.extract! entrega, :id, :nome, :endereco, :processo, :created_at, :updated_at
json.url entrega_url(entrega, format: :json)
