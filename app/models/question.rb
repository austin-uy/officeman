class Question < ApplicationRecord
  enum answer_type: [:text, :numerical, :choice]
  serialize :choices, Array
  has_many :answers, dependent: :destroy
  validates :question, presence: true
  validates :answer_type, presence: true
  validates :choices, presence: true, if: :test

  def test
    self.choice?
  end
end
