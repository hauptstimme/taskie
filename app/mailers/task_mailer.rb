class TaskMailer < ActionMailer::Base
  default from: ENV["MAIL_USER"]

  def new_task task
    @task = task
    mail to: @task.assignee.email, subject: "Assigned task: #{@task.name_with_id}"
  end
end
