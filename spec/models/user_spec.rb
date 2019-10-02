require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "has valid attributes" do
    user = build(:user)
    expect(user).to  be_valid
  end

  it "has a unique name" do
    user = create(:user)
    user2 = build(:user, email: "user2@localhost")
    expect(user2).to_not be_valid  
  end

  it "has a unique email" do
    user = create(:user)
    user2 = build(:user, name: "user2")
    expect(user2).to_not be_valid  
  end
  
  it "is not valid without a name" do
    user = build(:user, name: nil)
    expect(user).to_not be_valid  
  end

  it "is not valid without a password" do
    user = build(:user, password: nil)
    expect(user).to_not be_valid  
  end

  it "is not valid without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid  
  end

  it "when admin has valid attributes" do
    admin = build(:admin)
    expect(admin).to  be_valid
  end
end
