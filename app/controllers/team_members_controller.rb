class TeamMembersController < ApplicationController
  before_action :set_project, only: [:index, :new]

  def index
    @team_members = @project.team_members.includes(:user)
    authorize @project, :view_team_members?
  end

  def new
    @users = User.not_on_team(@project).reject do |user|
      @project.owner == user
    end
    authorize @project, :add_team_members?
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end
end
