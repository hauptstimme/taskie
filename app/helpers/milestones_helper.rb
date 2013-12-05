module MilestonesHelper
  def progress_bar(value)
    if (0..1).cover? value
      content_tag :div, nil, class: "progress-bar#{" progress-bar-success" if value == 1}", style: "width: #{value * 100}%;"
    end
  end
end
