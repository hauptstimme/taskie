module Api
  class TasksController < Api::BaseController
    before_action :set_tasks
    before_action :set_task, only: :show

    def index
      render json: @tasks
    end

    def show
      render json: @task
    end

    private

    def set_tasks
      @project = current_user.projects.find_by_id(params[:project_id])
      @tasks = @project.tasks rescue nil
    end

    def set_task
      @task = @tasks.find_by_id(params[:id]) rescue nil
    end
  end
end
