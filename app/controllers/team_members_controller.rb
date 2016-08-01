class TeamMembersController < ApplicationController
  before_action :set_project, only: [:index]

  def index
    @team_members = @project.team_members.includes(:user)
    authorize @project, :view_team_members?
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end
end
