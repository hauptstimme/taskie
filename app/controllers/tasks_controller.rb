class TasksController < ApplicationController
  before_action :set_project
  before_action :set_associations, only: [:new, :edit]
  before_action :set_task, only: [:show, :edit, :follow, :update, :destroy]
  layout "projects_nested", only: :index

  def index
    tasks =
      @project
      .tasks
      .includes(:comments, :creator, :assignee, :milestone)
      .sorted
      .page(params[:page])

    @tasks =
      if current_user.tasks_per_page > 0
        tasks.per(current_user.tasks_per_page)
      else
        tasks
      end
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

  def follow
    if @task.follower_ids.include? current_user.id
      @task.followers.delete current_user
    else
      @task.add_follower(current_user)
    end
    redirect_to project_task_path
  end

  def create
    @task = @project.tasks.new(task_params.merge(creator: current_user))

    if @task.save
      redirect_to project_task_path(id: @task), notice: 'Task was successfully created.'
    else
      set_associations
      render action: 'new'
    end
  end

  def update
    if params[:task][:status].present?
      if @task.update(task_params)
        @task.create_activity :update, owner: current_user, parameters: { type: "status", changes: @task.status }
      end
    elsif @task.update(task_params)
      @task.create_activity(
        :update,
        owner: current_user,
        parameters: {
          type: 'full',
          changes: @task.previous_changes.reject { |k| k == 'updated_at' }
        }
      )
      redirect_to project_task_path(id: @task), notice: 'Task was successfully updated.'
    else
      set_associations
      render action: 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def set_associations
    @users = @project.users.pluck(:username, :id)
    @milestones = @project.milestones.pluck(:title, :id)
  end

  def task_params
    permitted =
      if params[:task][:status].present?
        [:status]
      else
        [:assignee_id, :name, :details, :priority, :milestone_id]
      end

    params.require(:task).permit(permitted)
  end
end
