class RemoveInvitedEmailFromTeamMembers < ActiveRecord::Migration
  def change
    remove_column :team_members, :invited_email, :string
  end
end
