json.extract! question, :id, :Question, :variety, :subgenre_id, :created_at, :updated_at
json.url question_url(question, format: :json)
