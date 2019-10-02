FactoryBot.define do
  factory :text, class: Question do
    question { "What?" }
    answer_type { "text" }
    show_in_list { true }
  end

  factory :numerical, class: Question do
    question { "How many?" }
    answer_type { "numerical" }
    show_in_list { true }
  end

  factory :choice, class: Question do
    question { "Which?" }
    answer_type { "choice" }
    show_in_list { true }
    choices { ["a", "b", "c"] }
  end
end