class Task < ActiveRecord::Base
  belongs_to :assignee, class_name: "User"

  scope :active, -> { where "status = ?", false }
  scope :completed, -> { where "status = ?", true }
end
