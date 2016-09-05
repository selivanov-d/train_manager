json.array!(@trains) do |train|
  json.extract! train, :id, :number
  json.url train_url(train, format: :json)
end
