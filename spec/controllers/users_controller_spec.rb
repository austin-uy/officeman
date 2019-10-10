require 'rails_helper'
include ActionDispatch::TestProcess

RSpec.describe UsersController, type: :controller do
  
  let(:admin){ create(:admin) }
  let(:user){ create(:user) }

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

  it "should create user" do
    post :create, :params => { user: { name: "Another User", role: "user", picture: fixture_file_upload(Rails.root.join('spec', 'photos', 'lorem.jpg'), 'image/jpeg')} }
    expect(response.content_type).to eq "text/html"
  end
  
  it "should not show user" do
    get :show, :params => { id: user.id }
    expect(response).to_not be_successful
  end
  
  it "should get edit" do
    get :edit, :params => { id: user.id }
    expect(response).to be_successful
  end
  
  it "should update user" do
    put :update, :params => { id: user.id, user: { name: "new name" } }
    expect(response.content_type).to eq "text/html"
  end
  
  it "should delete user" do
    delete :destroy, :params => { id: user.id }
    expect(response.content_type).to eq "text/html"
  end

  it "should get profile" do
    get :profile
    expect(response).to be_successful
  end
end
