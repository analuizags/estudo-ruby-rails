json.extract! customer, :id, :name, :document, :email, :birthdate, :created_at, :updated_at
json.url customer_url(customer, format: :json)
