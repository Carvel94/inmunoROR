json.array!(@administrator_tips) do |administrator_tip|
  json.extract! administrator_tip, :id, :titulo, :contenido, :tags, :usuario_id
  json.url administrator_tip_url(administrator_tip, format: :json)
end
