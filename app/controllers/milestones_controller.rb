class MilestonesController < ApplicationController
  before_action :set_project
  before_action :set_milestone, only: [:show, :edit, :update, :destroy]
  layout "projects_nested", only: :index

  def index
  end

  def show
    @tasks = @milestone.tasks.includes(:comments, :creator, :assignee).sorted
  end

  def new
    @milestone = @milestones.new
  end

  def edit
  end

  def create
    @milestone = @milestones.new(milestone_params)

    if @milestone.save
      redirect_to project_milestone_path(id: @milestone), notice: 'Milestone was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @milestone.update(milestone_params)
      redirect_to project_milestone_path(id: @milestone), notice: 'Milestone was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @milestone.destroy
    redirect_to project_milestones_path(@project), notice: 'Milestone was successfully destroyed.'
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
    @milestones = @project.milestones.order title: :asc
  end

  def set_milestone
    @milestone = @milestones.find(params[:id])
  end

  def milestone_params
    params.require(:milestone).permit(:title, :due_date)
  end
end
