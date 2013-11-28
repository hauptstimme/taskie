module TasksHelper
  def status_to_label status
    if status
      content_tag :span, "Completed", class: "label label-success"
    else
      content_tag :span, "Active", class: "label label-primary"
    end
  end

  def status_label_for task
    status_to_label task.status
  end

  def check_box_with_status_for task
    form_for task, url: project_task_path(project_id: task.project_id, id: task), remote: true, html: { class: "form-inline status-toggle" } do |f|
        f.check_box(:status) + status_label_for(task)
    end
  end

  def tasks_filter_select
    content_tag :div, class: "btn-group" do
      task_scopes_for_filter.map do |scope|
        link_to scope.titleize, project_tasks_path(filter: scope, page: params[:page]), class: "btn btn-sm btn-default"
      end.join.html_safe
    end
  end

  def task_scopes_for_filter
    ["all", "active", "completed"]
  end

  def priority_badge task_or_priority
    priority = task_or_priority.is_a?(Task) ? task_or_priority.priority : task_or_priority
    content_tag :span, priorities[priority][0], class: "badge #{priorities[priority][1]}"
  end

  def priorities
    {
      1 => ["low", "badge-blue"],
      2 => ["normal", "badge-green"],
      3 => ["high", "badge-orange"],
      4 => ["critical", "badge-red"]
    }
  end
end
