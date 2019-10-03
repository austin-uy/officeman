require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user){ create(:user) }
  let(:question){ create(:text) }
  let(:answer){ create(:answer, question_id: question.id, user_id: user.id) }

  before(:each) do
    sign_in user
  end

  it "should get index" do
      get :index
      expect(response).to be_successful
  end

  it "should get new" do
    get :new
    expect(response).to be_successful
  end

  it "should create answer" do
    post :create, :params => { answer: {answer: answer.answer, question_id: question.id, user_id: user.id} }
    expect(response.content_type).to eq "text/html"
  end
  
  it "should show answer" do
    get :show, :params => { id: answer.id }
    expect(response).to be_successful
  end
  
  it "should get edit" do
    get :edit, :params => { id: answer.id }
    expect(response).to be_successful
  end
  
  it "should update answer" do
    put :update, :params => { id: answer.id, answer: { answer: "Updated answer"} }
    expect(response.content_type).to eq "text/html"
  end
  
  it "should delete answer" do
    delete :destroy, :params => { id: answer.id }
    expect(response.content_type).to eq "text/html"
  end
end
