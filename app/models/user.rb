class User < ActiveRecord::Base
  # available: :confirmable, :lockable, :timeoutable, :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  attr_accessor :login

  has_many :comments
  has_and_belongs_to_many :projects
  has_many :owned_projects, class_name: "Project", foreign_key: :owner_id
  has_many :created_tasks, class_name: "Task", foreign_key: :creator_id
  has_many :assigned_tasks, class_name: "Task", foreign_key: :assignee_id
  has_and_belongs_to_many :followed_tasks, class_name: "Task"

  scope :active, -> { where "last_sign_in_at is not ?", nil }

  validates :username,
    presence: true,
    length: 3..24,
    format: /\A[[:alpha:]][[:alnum:]]*\z/,
    uniqueness: {
      case_sensitive: false
    }
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }, allow_blank: true

  before_create :set_defaults

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

  def reset_api_key
    set_api_key
    save
  end

  private

  def set_defaults
    self.tasks_per_page ||= Kaminari.config.default_per_page
    set_api_key
  end

  def set_api_key
    begin
      self.api_key = SecureRandom.hex(16)
    end while User.exists?(api_key: self.api_key)
  end
end
