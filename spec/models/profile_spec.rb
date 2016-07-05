require 'rails_helper'

describe Profile do
  let (:profile) { FactoryGirl.build(:profile) }

  it "is valid with a username and personal website" do
    expect(profile).to be_valid
  end

  it "is valid with just a username" do
    profile.website = nil
    expect(profile).to be_valid
  end

  it "is invalid without a username" do
    profile.username = nil
    expect(profile).not_to be_valid
  end

  it "cannot update username" do
    profile.save
    expect(profile.update(username: "cannot_change")).to be_falsey
  end
end
