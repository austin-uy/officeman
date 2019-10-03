require 'rails_helper'

RSpec.describe Equipment, type: :model do
  
  it "has valid attributes" do
    user = create(:user)
    equipment = build(:equipment, user_id: user.id)
    expect(equipment).to be_valid
  end
  
  it "is not valid without a name" do
    user = create(:user)
    equipment = build(:equipment, user_id: user.id, name: nil)
    expect(equipment).to_not be_valid
  end
  
  it "is not valid without an equipment_type" do
    user = create(:user)
    equipment = build(:equipment, user_id: user.id, equipment_type: nil)
    expect(equipment).to_not be_valid
  end
  
  it "is not valid without a status" do
    user = create(:user)
    equipment = build(:equipment, user_id: user.id, status: nil)
    expect(equipment).to_not be_valid
  end

  it "is not valid without a user" do
    user = create(:user)
    equipment = build(:equipment)
    expect(equipment).to_not be_valid
  end
end
