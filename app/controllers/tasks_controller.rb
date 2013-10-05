class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_users, only: [ :new, :edit ]
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    case request.referrer
    when tasks_url, task_url
      @referrer = request.referrer
      @success = @task.update(task_params)
    else
      if @task.update(task_params)
        redirect_to @task, notice: 'Task was successfully updated.'
      else
        render action: 'edit'
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit([:assignee_id, :name, :details, :status])
  end

  def set_users
    @users ||= User.all.map{ |n| [ n.email, n.id ] }
  end
end
