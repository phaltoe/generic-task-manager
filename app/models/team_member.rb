class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  enum :role => [:view, :edit]

  def self.create_multiple(team_members_attrs)
    begin
      TeamMember.transaction do
        team_members_attrs.each do |k,attrs|
          unless attrs[:role] == 'none'
            team_member = self.create!(user_id: attrs[:user_id], project_id: attrs[:project_id])
            team_member.send("#{attrs[:role]}!")
          end
        end
      end
      true
    rescue
      false
    end
  end

  def self.update_multiple(team_members_attrs)
    begin
      TeamMember.transaction do
        team_members_attrs.each do |team_member_id, attrs|
          if attrs[:role] == 'none'
            TeamMember.find_by(id: team_member_id).destroy
          else
            team_member = TeamMember.find_by(id: team_member_id)
            team_member.send("#{attrs[:role]}!")
          end
        end
      end
      true
    rescue
      false
    end
  end
end
