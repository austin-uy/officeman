json.extract! question, :id, :question, :answer_type, :show_in_list, :created_at, :updated_at
json.url question_url(question, format: :json)
