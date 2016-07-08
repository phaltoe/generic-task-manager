class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.integer :role, :default => 0
      t.boolean :accepted, :default => false
      t.string :invited_email

      t.timestamps null: false
    end
  end
end
