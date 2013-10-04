class TaskMailer < ActionMailer::Base
  default from: ENV["MAIL_USER"]

  def task_assigned task
    @task = task
    mail to: @task.assignee.email, subject: "Assigned task: #{@task.name_with_id}"
  end
end
