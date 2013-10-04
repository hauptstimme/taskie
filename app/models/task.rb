class Task < ActiveRecord::Base
  belongs_to :assignee, class_name: "User"

  scope :active, -> { where "status = ?", false }
  scope :completed, -> { where "status = ?", true }

  after_save :notify_assignee, if: ->{ assignee_id_changed? }

  def name_with_id
    [ "##{id}", name ].compact.join(" ")
  end

  private

  def notify_assignee
    TaskMailer.task_assigned(self).deliver
  end
end
