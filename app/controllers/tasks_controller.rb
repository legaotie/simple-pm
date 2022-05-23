class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET projects/1/tasks
  def index
    @tasks = @project.tasks
  end

  # GET projects/1/tasks/1
  def show
  end

  # GET projects/1/tasks/new
  def new
    @task = Task.new
  end

  # GET projects/1/tasks/1/edit
  def edit
  end

  # POST projects/1/tasks
  def create
    @task = Task.new(task_params)
    @task.project = @project
    if @task.save
      redirect_to(@task.project)
    else
      render action: 'new'
    end
  end

  # PUT projects/1/tasks/1
  def update
    if @task.update(task_params)
      redirect_to(@task.project)
    else
      render action: 'edit'
    end
  end

  # DELETE projects/1/tasks/1
  def destroy
    @task.destroy

    redirect_to @project
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :status)
    end
end
