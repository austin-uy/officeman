class Question < ApplicationRecord
  enum answer_type: [:text, :numerical, :choice]
  serialize :choices, Array
end
