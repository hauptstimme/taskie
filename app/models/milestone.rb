class Milestone < ActiveRecord::Base
  belongs_to :project
  has_many :tasks, dependent: :nullify

  validates_presence_of :project, :title
end
