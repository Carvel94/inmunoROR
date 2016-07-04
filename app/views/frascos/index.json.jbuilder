json.array!(@frascos) do |frasco|
  json.extract! frasco, :id
  json.url frasco_url(frasco, format: :json)
end
