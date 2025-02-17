class SleepHistory < ApplicationRecord
  belongs_to :user

  validates :sleep_time, presence: true
  validate :active_sleep_timer, on: :create

  scope :newest, -> { order(created_at: :desc) }
  scope :active, -> { where(wake_up_time: nil) }

  def active_sleep_timer
    return unless user.present? && user.fall_asleep?
    errors.add(:base, "You already started your sleep timer. If you're awake now, please stop the previous one before starting a new one.")
  end
end
