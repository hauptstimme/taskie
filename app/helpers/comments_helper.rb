module CommentsHelper
  def time_distance_with_tooltip time
    content_tag :span, distance_of_time_in_words(time, Time.now), class: "has-tooltip", data: { title: time.to_s(:long) }
  end
end
