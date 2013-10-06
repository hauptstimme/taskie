class Project < ActiveRecord::Base
  has_many :tasks, dependent: :nullify
end
