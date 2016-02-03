module Api
  class MilestonesController < Api::BaseController
    before_action :set_milestones
    before_action :set_milestone, only: :show

    def index
      render json: @milestones
    end

    def show
      render json: @milestone
    end

    private

    def set_milestones
      @project = current_user.projects.find_by(id: params[:project_id])
      @milestones = @project&.milestones
    end

    def set_milestone
      @milestone = @milestones&.find_by_id(params[:id])
    end
  end
end
