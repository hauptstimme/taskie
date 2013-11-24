class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :task, presence: true
  validates :user, presence: true
  validates :text, presence: true

  before_update :modifiable?
  before_destroy :modifiable?
  after_save :notify_creator, if: ->{ user != task.creator and task.creator != task.assignee }
  after_save :notify_assignee, if: ->{ user != task.assignee and task.assignee_id.present? }

  default_scope ->{ order :created_at }

  def modifiable?
    created_at > 1.day.ago
  end

  def notify_creator
    TaskMailer.new_comment_creator(self).deliver
  end

  def notify_assignee
    TaskMailer.new_comment_assignee(self).deliver
  end
end
