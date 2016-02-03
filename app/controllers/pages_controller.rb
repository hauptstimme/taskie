class PagesController < ApplicationController
  def dashboard
    @active_tasks_by_projects =
      current_user
      .assigned_tasks
      .active
      .includes(:creator, :project, :comments, :milestone)
      .order(:project_id)
      .sorted
      .group_by(&:project)
  end
end
