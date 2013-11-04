class Project < ActiveRecord::Base
  has_many :tasks, dependent: :restrict_with_exception
  has_and_belongs_to_many :users

  validates :name, presence: true
end
