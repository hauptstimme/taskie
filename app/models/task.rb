class Task < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :assignee, class_name: "User"
  belongs_to :creator, class_name: "User"
  belongs_to :project
  belongs_to :milestone
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :followers, class_name: "User"
  has_and_belongs_to_many :tags, -> { distinct }

  validates_presence_of :name, :project, :creator, :priority

  after_create :set_followers
  after_save :notify_assignee, if: ->{ assignee_id_changed? and assignee_id.present? }

  scope :sorted, -> { order :status, priority: :desc, updated_at: :desc }
  scope :active, -> { where "status = ?", false }
  scope :completed, -> { where "status = ?", true }
  scope :without_project, -> { where "project_id = ?", nil }

  def name_with_id
    "##{id} #{name}"
  end

  def follower?(user)
    follower_ids.include? user.id
  end

  def add_follower(user)
    self.followers << user if !follower?(user) and user.auto_follow_tasks
  end

  def remove_follower(user)
    self.followers.delete user if follower?(user)
  end

  def toggle_follower(user)
    if follower?(user)
      self.followers.delete user
    else
      self.followers << user
    end
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
