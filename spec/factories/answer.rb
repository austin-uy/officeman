FactoryBot.define do
  factory :answer do
    answer { 'lorem ipsum' }
    question_id { nil }
    user_id { nil }
  end
end
