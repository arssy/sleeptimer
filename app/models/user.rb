class User < ApplicationRecord
  has_many :sleep_histories, dependent: :destroy
  has_many :followers, class_name: "Follower", foreign_key: :following_id, dependent: :destroy
  has_many :followings, class_name: "Follower", foreign_key: :user_id, dependent: :destroy

  def fall_asleep?
    sleep_histories.active.exists?
  end
end
