class Api::ProjectsController < Api::BaseController
  before_action :set_projects
  before_action :set_project, only: :show

  def index
    render json: @projects
  end

  def show
    render json: @project
  end

  private

  def set_projects
    @projects = current_user.projects.includes(:owner, :users)
  end

  def set_project
    @project = @projects.find_by_id(params[:id])
  end
end
