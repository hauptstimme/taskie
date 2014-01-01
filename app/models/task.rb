class Task < ActiveRecord::Base
  include PublicActivity::Common

  enum status: [:active, :completed], priority: { low: 1, normal: 2, high: 3, critical: 4 }

  belongs_to :assignee, class_name: "User"
  belongs_to :creator, class_name: "User"
  belongs_to :project
  belongs_to :milestone
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :followers, class_name: "User"

  validates_presence_of :name, :project, :creator

  after_create :set_followers
  after_save :notify_assignee, if: ->{ assignee_id_changed? and assignee_id.present? and assignee_id != creator_id }

  scope :sorted, -> { order :status, priority: :desc, updated_at: :desc }

  def name_with_id
    "##{id} #{name}"
  end

  def add_follower(user)
    self.followers << user if !self.follower_ids.include?(user.id) && user.auto_follow_tasks
  end

  private

  def set_followers
    add_follower creator
  end

  def notify_assignee
    add_follower assignee
    TaskMailer.task_assigned(self).deliver
  end
end
