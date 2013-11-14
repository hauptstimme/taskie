class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_users, only: [:new, :edit]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @project.tasks.includes(:comments).sorted.page(params[:page])
  end

  def show
    @comments = @task.comments.includes(:user)
    @comment = @comments.new
  end

  def new
    @task = @project.tasks.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)

    if @task.save
      redirect_to project_task_path(id: @task), notice: 'Task was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if request.patch?
      @referrer = request.referrer
      @success = @task.update(task_params)
    else
      if @task.update(task_params)
        redirect_to project_task_path(id: @task), notice: 'Task was successfully updated.'
      else
        render action: 'edit'
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private

  def set_project
    @project ||= current_user.projects.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def set_users
    @users ||= @project.users.map{ |n| [n.email, n.id] }
  end

  def task_params
    params.require(:task).permit(:assignee_id, :name, :details, :status)
  end
end
