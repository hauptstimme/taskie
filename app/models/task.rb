class Task < ActiveRecord::Base
  belongs_to :assignee, class_name: "User"

  scope :active, -> { where "status = ?", false }
  scope :completed, -> { where "status = ?", true }

  def name_with_id
    [ "##{id}", name ].compact.join(" ")
  end
end
