class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :tickets, dependent: :destroy

  validates :first_name, presence: true
  validates :family_name, presence: true

  validates :first_name, uniqueness: {
    scope: :family_name,
    case_sensitive: false
  }

  def full_name
    "#{first_name} #{family_name}"
  end
end
