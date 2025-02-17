class User < ApplicationRecord
  has_many :sleep_histories, dependent: :destroy

  def fall_asleep?
    sleep_histories.active.exists?
  end
end
