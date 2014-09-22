json.array!(@events) do |event|
  json.extract! event, :title, :description
  json.url event_url(event, format: :json)
end
