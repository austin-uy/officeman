require 'rails_helper'

RSpec.describe EquipmentController, type: :controller do
  let(:admin){ create(:admin) }
  let(:user){ create(:user) }
  let(:equipment){ create(:equipment, user_id: user.id) }

  before(:each) do
    sign_in admin
  end

  it "should get index" do
    get :index
    expect(response).to be_successful
  end

  it "should get new" do
    get :new
    expect(response).to be_successful
  end

  it "should create equipment" do
    post :create, :params => { equipment: {equipment: "new", equipment_type: "hardware", status: "stored", user_id: user.id} }
    expect(response.content_type).to eq "text/html"
  end
  
  it "should show equipment" do
    get :show, :params => { id: equipment.id }
    expect(response).to be_successful
  end
  
  it "should get edit" do
    get :edit, :params => { id: equipment.id }
    expect(response).to be_successful
  end
  
  it "should update equipment" do
    put :update, :params => { id: equipment.id, equipment: { equipment: "Updated equipment"} }
    expect(response.content_type).to eq "text/html"
  end
  
  it "should delete equipment" do
    delete :destroy, :params => { id: equipment.id }
    expect(response.content_type).to eq "text/html"
  end
end
