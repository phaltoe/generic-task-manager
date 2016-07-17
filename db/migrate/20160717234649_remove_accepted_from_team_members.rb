class RemoveAcceptedFromTeamMembers < ActiveRecord::Migration
  def change
    remove_column :team_members, :accepted, :boolean, :default => false
  end
end
