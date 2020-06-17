json.extract! question, :id, :name, :description, :acceptance_criterias, :created_at, :updated_at
json.url question_url(question, format: :json)
