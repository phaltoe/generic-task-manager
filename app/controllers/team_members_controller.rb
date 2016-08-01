class TeamMembersController < ApplicationController
  before_action :set_project, only: [:index, :new, :create, :update_multiple]

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

  def create
    authorize @project, :add_team_members?
    if TeamMember.create_multiple(team_members_params[:users])
      redirect_to project_team_members_path(@project), notice: 'Permissions updated!'
    else
      flash[:alert] = "There was an issue updating user permissions. Try again."
      @users = User.not_on_team(@project).reject do |user|
        @project.owner == user
      end
      render :new
    end
  end

  def update_multiple
    authorize @project, :edit_permissions?
    if TeamMember.update_multiple(team_members_params[:users])
      redirect_to project_team_members_path(@project), notice: 'Permissions updated!'
    else
      binding.pry
      flash[:alert] = "There was an issue updating user permissions. Try again."
      @team_members = @project.team_members.includes(:user)
      render :index
    end
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def team_members_params
    params.permit(users: [:role, :project_id, :user_id])
  end
end
