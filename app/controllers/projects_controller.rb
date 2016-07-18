class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = current_user.projects.build
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project), notice: 'Your new project has been created!'
    else
      render :edit, alert: 'There was a problem saving your project.'
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
    authorize @project
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to projects_path, notice: "#{@project.title} was destroyed successfully."
  end

  private

  def set_project
    @project = current_user.projects.find_by(id: params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:title, :description, :user_id, :emails_invited)
  end
end
