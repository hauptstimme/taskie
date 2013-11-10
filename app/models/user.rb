class User < ActiveRecord::Base
  # available: :token_authenticatable, :confirmable, :lockable, :timeoutable, :omniauthable, :registerable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_and_belongs_to_many :projects
  has_many :owned_projects, class_name: "Project", foreign_key: :owner_id
end
