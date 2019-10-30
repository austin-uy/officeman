require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:answer_types) { Question.answer_types.keys.map(&:to_sym) }

  it 'has valid attributes' do
    question = build(answer_types.sample)
    expect(question).to be_valid
  end

  it 'is not valid without a question' do
    question = build(answer_types.sample, question: nil)
    expect(question).to_not(be_valid)
  end

  it 'is not valid without an answer_type' do
    question = build(answer_types.sample, answer_type: nil)
    expect(question).to_not(be_valid)
  end

  it 'of answer_type `choice` is not valid without choices' do
    question = build(:choice, choices: nil)
    expect(question).to_not(be_valid)
  end
end
