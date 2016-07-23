class TasksController < ApplicationController
  def new
    @project = Project.find_by(id: params[:project_id])
    @task = @project.tasks.build
    authorize @task
  end

  def create
    @project = Project.find_by(id: params[:project_id])
    @task = @project.tasks.new(task_params)
    authorize @task
    if @task.save
      redirect_to project_path(@task.project)
    else
      flash[:alert] = "Sorry, we couldn't save the task."
      render :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    authorize @task
  end

  def update
    @task = Task.find_by(id: params[:id])
    authorize @task
    if @task.update(task_params)
      redirect_to project_path(@task.project)
    else
      flash[:alert] = "Sorry, we couldn't update the task."
      render :edit
    end
  end

  def destroy
    @project = Project.find_by(id: params[:project_id])
    @task = @project.tasks.find_by(id: params[:id])
    authorize @task
    @task.destroy
    redirect_to project_path(@project), notice: "Task destroyed."
  end

  def toggle_complete
    @project = Project.find_by(id: params[:project_id])
    @task = @project.tasks.find_by(id: params[:id])
    authorize @task
    @task.completed = !@task.completed
    @task.save
    redirect_to project_path(@project)
  end

    private

    def task_params
      params.require(:task).permit(:description, :completed)
    end
end
