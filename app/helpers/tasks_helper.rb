module TasksHelper
  def status_label_for task
    if task.status
      content_tag :span, "Completed", class: "label label-success"
    else
      content_tag :span, "Active", class: "label label-primary"
    end
  end

  def check_box_with_status_for task
    form_for task, remote: true, html: { class: "form-inline status-toggle" } do |f|
      content_tag :div, class: "checkbox" do
        f.check_box(:status) + status_label_for(task)
      end
    end
  end

  def render_markdown text
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    @markdown.render(text).html_safe
  end
end
