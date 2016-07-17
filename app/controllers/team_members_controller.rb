class TeamMembersController < ApplicationController
  def index
    @project = Project.find_by(:id => :project_id)
    @team_members = @project.team_members
  end
end
