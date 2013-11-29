class Task < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :assignee, class_name: "User"
  belongs_to :creator, class_name: "User"
  belongs_to :project
  belongs_to :milestone
  has_many :comments, dependent: :destroy

  validates_presence_of :name, :project, :creator, :priority

  after_save :notify_assignee, if: ->{ assignee_id_changed? and assignee_id.present? }

  scope :sorted, -> { order :status, priority: :desc, updated_at: :desc }
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
