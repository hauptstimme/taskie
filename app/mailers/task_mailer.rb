class TaskMailer < ActionMailer::Base
  default from: ENV["MAIL_USER"] || "taskie@hauptstimme.tk"

  def task_assigned task
    raise if task.assignee_id.blank?
    @task = task
    @project = @task.project
    mail to: @task.assignee.email, subject: "Assigned task: #{@task.name}"
  end

  def new_comment comment, receiver
    @receiver = receiver
    @comment = comment
    @task = @comment.task
    @project = @task.project
    mail to: @receiver.email, subject: "New comment in task #{@task.name}"
  end
end
