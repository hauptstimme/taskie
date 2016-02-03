module MilestonesHelper
  def progress_bar(value, range, options = {})
    if (0..range).cover?(value)
      percentage = value / range.to_f
      outer_class = ['progress', 'has-tooltip', options[:outer_class]].compact
      inner_class = ['progress-bar', ('progress-bar-success' if percentage == 1)].compact

      content_tag :div, class: outer_class, title: "#{value}/#{range}" do
        content_tag :div, nil, class: inner_class, style: "width: #{(percentage * 100).round(2)}%;"
      end
    end
  end
end
