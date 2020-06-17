json.extract! customer, :id, :name, :dni, :created_at, :updated_at
json.url customer_url(customer, format: :json)
