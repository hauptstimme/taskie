class Task < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :assignee, class_name: "User"
  belongs_to :project
  belongs_to :creator, class_name: "User"
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :creator, presence: true
  validates :priority, presence: true

  after_save :notify_assignee, if: ->{ assignee_id_changed? and assignee_id.present? }

  scope :by_updated_at, -> { order updated_at: :desc }
  scope :by_priority, -> { order priority: :desc }
  scope :by_status, -> { order :status }
  scope :sorted, -> { by_status.by_priority.by_updated_at }
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
