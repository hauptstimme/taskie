class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :task, presence: true
  validates :user, presence: true
  validates :text, presence: true

  before_update :modifiable?
  before_destroy :modifiable?
  after_create :notify

  default_scope ->{ order :created_at }

  def modifiable?
    created_at > 1.day.ago
  end

  def notify
    TaskMailer.new_comment(self, task.assignee).deliver if task.assignee_id.present? && task.assignee != user
    TaskMailer.new_comment(self, task.creator).deliver if task.creator != task.assignee && task.creator != user
  end
end
