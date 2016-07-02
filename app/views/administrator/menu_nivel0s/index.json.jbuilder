json.array!(@administrator_menu_nivel0s) do |administrator_menu_nivel0|
  json.extract! administrator_menu_nivel0, :id
  json.url administrator_menu_nivel0_url(administrator_menu_nivel0, format: :json)
end
