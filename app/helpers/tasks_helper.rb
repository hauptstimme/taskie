module TasksHelper
  def status_label_for task
    if task.status
      content_tag :span, "Completed", class: "label label-success"
    else
      content_tag :span, "Active", class: "label label-primary"
    end
  end
end
