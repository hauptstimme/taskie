module MilestonesHelper
  def progress_bar(value, range, options = {})
    if (0..range).cover?(value)
      percentage = value / range.to_f
      content_tag :div, class: ["progress", "has-tooltip", options[:outer_class]].compact.join(" "), title: "#{value}/#{range}" do
        content_tag :div, nil, class: "progress-bar#{" progress-bar-success" if percentage == 1}", style: "width: #{(percentage*100).round(2)}%;"
      end
    end
  end
end
