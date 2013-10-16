class Project < ActiveRecord::Base
  has_many :tasks, dependent: :restrict_with_exception

  validates :name, presence: true
end
