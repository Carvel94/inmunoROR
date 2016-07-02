json.array!(@administrator_configurations) do |administrator_configuration|
  json.extract! administrator_configuration, :id, :imagen1, :imagen2, :imagen3, :imagen4, :imagen5, :usuario_id
  json.url administrator_configuration_url(administrator_configuration, format: :json)
end
