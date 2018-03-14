json.extract! tournament, :id, :title, :description, :date, :pricepool, :created_at, :updated_at
json.url tournament_url(tournament, format: :json)
