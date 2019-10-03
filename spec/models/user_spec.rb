require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:roles){User.roles.keys.map &:to_sym}
  it "has valid attributes" do
    user = build(roles.sample)
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
    user = build(roles.sample, name: nil)
    expect(user).to_not be_valid  
  end

  it "is not valid without a password" do
    user = build(roles.sample, password: nil)
    expect(user).to_not be_valid  
  end

  it "is not valid without an email" do
    user = build(roles.sample, email: nil)
    expect(user).to_not be_valid  
  end

end
