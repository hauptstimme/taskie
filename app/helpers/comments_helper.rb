module CommentsHelper
  def span_with_tooltip text, tooltip
    content_tag :span, text, class: "has-tooltip", data: { title: tooltip }
  end

  # TODO
  def activity_details_with_tooltip text, tooltip
    span_with_tooltip text, tooltip
  end

  def time_distance_with_tooltip time
    span_with_tooltip distance_of_time_in_words(time, Time.now), time.to_s(:long)
  end
end
