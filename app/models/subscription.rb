class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }
  validate :check_user_email, unless: -> { user.present? }
  validate :possibility_user_subscribe, if: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def check_user_email
    if User.find_by(email: user_email)
      errors.add(:user_email, I18n.t('errors.check_user_email'))
    end
  end

  def possibility_user_subscribe
    if event.user == user
      errors.add(:user, I18n.t('errors.possibility_user_subscribe'))
    end
  end
end
