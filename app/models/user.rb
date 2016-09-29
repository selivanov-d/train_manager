class User < ActiveRecord::Base
  has_many :tickets, dependent: :destroy

  validates :first_name, presence: { message: 'Имя пользователя обязательно!' }
  validates :family_name, presence: { message: 'Фамилия пользователя обязательна!' }

  # REVIEW: хотелось бы сделать так, чтобы валидировалась пара атрибутов, а не :first_name в связке с :family_name.
  # Имею ввиду, что в случае ошибки валидации подсвечено будет одно поле и сообщение об ошибке будет касаться только его, а не двух.
  validates :first_name, uniqueness: {
    scope: :family_name,
    case_sensitive: false,
    message: 'Пользователь с таким именем уже существует!'
  }

  def full_name
    "#{first_name} #{family_name}"
  end
end
