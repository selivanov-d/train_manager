class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :tickets, dependent: :destroy

  validates :first_name, presence: { message: 'Имя пользователя обязательно!' }
  validates :family_name, presence: { message: 'Фамилия пользователя обязательна!' }

  validates :first_name, uniqueness: {
    scope: :family_name,
    case_sensitive: false,
    message: 'Пользователь с таким именем уже существует!'
  }

  def full_name
    "#{first_name} #{family_name}"
  end
end
