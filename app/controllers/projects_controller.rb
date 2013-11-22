class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :set_new_project, only: :new
  before_action :set_users, only: [:new, :edit]

  def index
    @projects = current_user.projects.order(:created_at)
  end

  def show
    redirect_to project_tasks_path(params[:id])
  end

  def new
  end

  def edit
  end

  def create
    @project = current_user.owned_projects.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end

  private

  def set_new_project
    @project = current_user.owned_projects.new
  end

  def set_users
    @users = User.where("id != ?", @project.owner_id)
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :details, user_ids: [])
  end
end
