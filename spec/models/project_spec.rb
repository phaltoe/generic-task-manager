require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { FactoryGirl.build(:user) }
  let(:project) { FactoryGirl.build(:project, :owner => user)}

  it "knows about its owner" do
    expect(project.owner).to eq(user)
  end

  it "is valid with a title and description" do
    expect(project).to be_valid
  end

  it "is invalid without a title" do
    titleless_project = FactoryGirl.build(:project, :title => nil)
    expect(titleless_project).to be_invalid
  end

  it "is invalid without a description" do
    no_description = FactoryGirl.build(:project, :description => nil)
    expect(no_description).to be_invalid
  end

  context 'creating a new project' do
    it 'adds owner to team_members for project' do
      user.save
      project.save
      project.reload
      expect(project.team_members.first.user).to eq(user)
    end

    it 'gives owner a leader role' do
      user.save
      project.save
      project.reload
      expect(project.team_members.first.role).to eq('leader')
    end
  end
end
