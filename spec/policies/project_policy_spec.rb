require 'rails_helper'

describe ProjectPolicy do
  subject { described_class }

  let(:owner) { FactoryGirl.create(:user)}
  let(:lonely_user) { FactoryGirl.create(:user)}
  let(:owners_project) { FactoryGirl.create(:project, owner: owner)}

  permissions :show? do
    it "allows access to the project owner" do
      expect(subject).to permit(owner, owners_project)
    end

    it "allows access to a team member with edit role on the project" do
      owners_project.team_members.create(user: lonely_user, role: 'edit')
      expect(subject).to permit(lonely_user, owners_project)
    end

    it "does not allow access to a user that is not a team member or owner" do
      expect(subject).not_to permit(lonely_user, owners_project)
    end
  end
end
