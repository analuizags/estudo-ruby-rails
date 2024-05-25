json.extract! phone, :id, :ddd, :number, :customer_id, :created_at, :updated_at
json.url phone_url(phone, format: :json)
