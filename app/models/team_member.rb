class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  enum :role => [:view, :edit]

  def self.create_multiple(team_members_attrs)
    begin
      TeamMember.transaction do
        team_members_attrs.each do |k,team_member|
          unless team_member[:role] == 'none'
            user = self.create!(user_id: team_member[:user_id], project_id: team_member[:project_id])
            user.send("#{team_member[:role]}!")
          end
        end
      end
      true
    rescue
      false
    end
  end
end
