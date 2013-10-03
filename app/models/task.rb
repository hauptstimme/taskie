class Task < ActiveRecord::Base
  belongs_to :assignee, class_name: "User"

  scope :active, -> { where "status = ?", false }
  scope :completed, -> { where "status = ?", true }

  after_create :notify_assignee, if: ->{ assignee.present? }

  def name_with_id
    [ "##{id}", name ].compact.join(" ")
  end

  private

  def notify_assignee
    TaskMailer.new_task(task).deliver
  end
end
