module TasksHelper
  def status_label_for(task_or_status)
    if task_or_status.try(:completed?) || task_or_status.in?(["completed", 1])
      content_tag :span, t("tasks.completed"), class: "label label-success"
    else
      content_tag :span, t("tasks.active"), class: "label label-primary"
    end
  end

  def check_box_with_status_for(task)
    form_for task, url: project_task_path(project_id: task.project_id, id: task), remote: true, html: { class: "form-inline status-toggle" } do |f|
      f.check_box(:status, {}, "completed", "active") + status_label_for(task)
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

  def priority_badge(task_or_priority)
    priority =
      case task_or_priority
      when Integer
        Task::PRIORITY.invert[task_or_priority]
      when Task
        task_or_priority.priority
      else
        task_or_priority
      end
    content_tag :span, priority, class: "badge #{priority_to_class(priority)}"
  end

  def priority_to_class(n)
    "badge-" + HashWithIndifferentAccess.new(low: "blue", normal: "green", high: "orange", critical: "red")[n]
  end
end
