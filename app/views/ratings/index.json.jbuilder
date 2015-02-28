json.array!(@ratings) do |rating|
  json.extract! rating, :id, :score
  json.url beer_url(rating, format: :json)
end
