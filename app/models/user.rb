class User < ActiveRecord::Base
  # available: :token_authenticatable, :confirmable, :lockable, :timeoutable, :omniauthable, :registerable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
end
