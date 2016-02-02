class Project < ActiveRecord::Base
  has_many :tasks, dependent: :restrict_with_exception
  has_many :milestones, dependent: :restrict_with_exception
  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :users

  validates :name, :owner, presence: true

  after_save :add_owner_to_participants

  private

  def add_owner_to_participants
    users << owner
  end
end
