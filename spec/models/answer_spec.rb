require 'rails_helper'

RSpec.describe Answer, type: :model do
  
  it "has valid attributes" do
    user = create(:user)
    question = create(:text)
    answer = build(:answer, user_id: user.id, question_id: question.id)
    expect(answer).to be_valid
  end  

  it "is not valid without an answer" do
    user = create(:user)
    question = create(:text)
    answer = build(:answer, user_id: user.id, question_id: question.id, answer: nil)
    expect(answer).to_not be_valid
  end  

  it "is not valid without a question" do
    user = create(:user)
    answer = build(:answer, user_id: user.id)
    expect(answer).to_not be_valid
  end

  it "is not valid without a user" do
    question = create(:text)
    answer = build(:answer, question_id: question.id)
    expect(answer).to_not be_valid
  end
  
end
