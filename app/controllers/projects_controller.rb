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
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def set_project
    @project = current_user.projects.find_by(id: params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
