class User < ActiveRecord::Base
  # available: :token_authenticatable, :confirmable, :lockable, :timeoutable, :omniauthable, :registerable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  attr_accessor :login

  has_many :comments
  has_and_belongs_to_many :projects
  has_many :owned_projects, class_name: "Project", foreign_key: :owner_id

  validates :username,
    presence: true,
    length: 3..24,
    format: /\A[[:alpha:]][[:alnum:]]*\z/,
    uniqueness: {
      case_sensitive: false
    }

  class << self
    def find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first
      else
        where(conditions).first
      end
    end
  end
end
