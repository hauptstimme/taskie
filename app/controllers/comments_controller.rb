class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def create
    @comment = @task.comments.new(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to project_task_path(id: @task), notice: 'Comment was successfully posted.'
    else
      redirect_to project_task_path(id: @task), alert: "Don't submit empty comments!"
    end
  end

  def edit
    respond_to { |format| format.js }
  end

  def update
    @success = @comment.update(comment_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @comment.destroy
      redirect_to project_task_path(id: @task), notice: 'Comment was successfully deleted.'
    else
      redirect_to project_task_path(id: @task), alert: t('access.denied')
    end
  end

  private

  def set_project
    @project ||= Project.find(params[:project_id])
  end

  def set_task
    @task ||= @project.tasks.find(params[:task_id])
  end

  def set_comment
    @comment ||= @task.comments.where(user_id: current_user.id).find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
