require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  
  let(:admin){ create(:admin) }
  let(:question){ create(:text) }

  before(:each) do
    sign_in admin
  end

  it "should get index" do
      get :index
      expect(response).to be_successful
  end

  it "should not get new" do
    get :new
    expect(response).to_not be_successful
  end

  it "should create question" do
    post :create, :params => { question: {question: question.question, answer_type: question.answer_type, show_in_list: question.show_in_list} }
    expect(response.content_type).to eq "text/html"
  end
  
  it "should show question" do
    get :show, :params => { id: question.id }
    expect(response).to redirect_to questions_url
  end
  
  it "should get edit" do
    get :edit, :params => { id: question.id }
    expect(response).to be_successful
  end
  
  it "should update question" do
    put :update, :params => { id: question.id, question: { question: "Updated question"} }
    expect(response.content_type).to eq "text/html"
  end
  
  it "should delete question" do
    delete :destroy, :params => { id: question.id }
    expect(response.content_type).to eq "text/html"
  end

end
