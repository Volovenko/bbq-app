class Event < ApplicationRecord
  validates :title, presence: true, length: {maximum: 255}
  validates :address, presence: true
  validates :datetime, presence: true
    # Событие принадлежит юзеру
  belongs_to :user

  # Валидируем юзера на присутствие. В Rails 5 связи 
  # валидируются по умолчанию
  validates :user, presence: true
end
