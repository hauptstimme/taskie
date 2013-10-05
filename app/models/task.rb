class Task < ActiveRecord::Base
  belongs_to :assignee, class_name: "User"

  has_many :task_dependencies, foreign_key: :dependency_id
  has_many :dependents, through: :task_dependencies
  has_many :inverse_task_dependencies, class_name: "TaskDependency", foreign_key: :dependent_id
  has_many :dependencies, through: :inverse_task_dependencies

  scope :active, -> { where "status = ?", false }
  scope :completed, -> { where "status = ?", true }

  after_save :notify_assignee, if: ->{ assignee_id_changed? and assignee_id.present? }

  def name_with_id
    [ "##{id}", name ].compact.join(" ")
  end

  def completed?
    status
  end

  def active?
    !completed?
  end

  private

  def notify_assignee
    TaskMailer.task_assigned(self).deliver
  end
end
