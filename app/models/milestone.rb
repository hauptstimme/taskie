class Milestone < ActiveRecord::Base
  belongs_to :project
  has_many :tasks, dependent: :nullify

  validates :project, :title, presence: true
end
