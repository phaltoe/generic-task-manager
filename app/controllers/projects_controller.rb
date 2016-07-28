class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, :only => [:show, :edit, :update, :destroy, :add_team_members, :edit_permissions, :view_team_members]

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = current_user.projects.build
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    if @project.save
      redirect_to project_path(@project), notice: 'Your new project has been created!'
    else
      render :new, alert: 'There was a problem saving your project.'
    end
  end

  def edit
    authorize @project
  end

  def update
    @project = Project.find_by(id: params[:id])
    authorize @project
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Your project has been updated.'
    else
      render :edit, alert: 'There was a problem saving your changes.'
    end
  end

  def show
    @team_members = @project.team_members.reject { |team_member| team_member.user == @project.owner }
    @tasks = @project.tasks
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "#{@project.title} was destroyed successfully."
  end

  def add_team_members
    @users = User.not_on_team(@project).reject { |user| @project.owner == user }
  end

  def edit_permissions
    @team_members = @project.team_members.reject { |team_member| team_member.user == current_user }
  end

  def view_team_members
    @team_members = @project.team_members
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:title, :description, :user_id, team_members: [:id, :role])
  end
end
