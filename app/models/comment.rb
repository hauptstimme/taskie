class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :task, presence: true
  validates :user, presence: true
  validates :text, presence: true

  before_update :modifiable?
  before_destroy :modifiable?

  default_scope ->{ order :created_at }

  def modifiable?
    created_at > 1.day.ago
  end
end
