class Task < ActiveRecord::Base
  belongs_to :assignee, class_name: "User"
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :name, presence: true

  after_save :notify_assignee, if: ->{ assignee_id_changed? and assignee_id.present? }

  scope :active, -> { where "status = ?", false }
  scope :completed, -> { where "status = ?", true }
  scope :without_project, -> { where "project_id = ?", nil }

  def name_with_id
    "##{id} #{name}"
  end

  private

  def notify_assignee
    TaskMailer.task_assigned(self).deliver
  end
end
