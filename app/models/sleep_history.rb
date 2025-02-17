class SleepHistory < ApplicationRecord
  belongs_to :user

  validates :sleep_time, presence: true
  validates :wake_up_time, presence: true, on: :update
  validates :sleep_duration, presence: true, on: :update
  validate :active_sleep_timer, on: :create

  before_validation :calculate_sleep_duration, on: :update

  scope :newest, -> { order(created_at: :desc) }
  scope :active, -> { where(wake_up_time: nil) }

  def active_sleep_timer
    return unless user.present? && user.fall_asleep?
    errors.add(:base, "You already started your sleep timer. If you're awake now, please stop the previous one before starting a new one.")
  end

  def calculate_sleep_duration
    return unless wake_up_time.present?
    self.sleep_duration = wake_up_time - sleep_time
  end
end
