require 'rails_helper'

describe User do
  let (:user) { FactoryGirl.build(:user) }

  it "is valid with an email, password and username" do
    profile = FactoryGirl.build(:profile, user: user)
    expect(user).to be_valid
  end
  
  it "is invalid with an email that is not unique" do
    saved_user = FactoryGirl.create(:user, :email => user.email)
    expect(user).to_not be_valid
  end

  it "is invalid with a password that is too short" do
    user.password = 'short'
    expect(user).to_not be_valid
  end
  
  it "is invalid with a password that is too long" do
    user.password = "#{"x" * 129}"
    expect(user).to_not be_valid
  end

  it "is invalid without a username" do
    profile = FactoryGirl.build(:profile, user: user, username: nil)
    expect(user).to_not be_valid
  end

  it "does not return deleted accounts by default" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, active: false)
    expect(User.all.count).to eq(1)
  end
end
