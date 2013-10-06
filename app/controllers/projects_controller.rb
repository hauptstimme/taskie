class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :edit, :update, :destroy ]

  def index
    @projects = Project.all
  end

  def show
    redirect_to project_tasks_path(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path, notice: 'Project was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :details)
  end
end
