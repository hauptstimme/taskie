class TasksController < ApplicationController
  before_action :set_project
  before_action :set_users, only: [:new, :edit]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  layout "projects_nested", only: :index

  def index
    # TODO: Refactor
    per_page = current_user.tasks_per_page > 0 ? current_user.tasks_per_page : @project.tasks.count
    @tasks = @project.tasks.includes(:comments, :creator, :assignee).sorted.page(params[:page]).per(per_page)
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
    @task = @project.tasks.new(task_params.merge(creator: current_user))

    if @task.save
      redirect_to project_task_path(id: @task), notice: 'Task was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if request.patch? && request.referrer != edit_project_task_url
      if @task.update(task_params)
        @task.create_activity :update, owner: current_user, parameters: { type: "status", changes: @task.status }
      end
    else
      if @task.update(task_params)
        @task.create_activity :update, owner: current_user, parameters: { type: "full", changes: @task.previous_changes.reject{ |k| k == "updated_at" } }
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
    @users ||= @project.users.pluck(:username, :id)
  end

  def task_params
    params.require(:task).permit(:assignee_id, :name, :details, :status, :priority)
  end
end
