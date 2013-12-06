class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates_presence_of :task, :user, :text

  before_update :modifiable?
  before_destroy :modifiable?
  after_create :notify_followers

  default_scope ->{ order :created_at }

  def modifiable?
    created_at > 1.day.ago
  end

  private

  def notify_followers
    task.followers.where.not("id = ?", user.id).each do |follower|
      TaskMailer.new_comment(self, follower).deliver
    end
  end
end
