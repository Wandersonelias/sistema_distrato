json.extract! funcionario, :id, :nome, :setor, :user_id, :created_at, :updated_at
json.url funcionario_url(funcionario, format: :json)
