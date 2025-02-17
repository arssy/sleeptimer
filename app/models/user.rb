class User < ApplicationRecord
  has_many :sleep_histories, dependent: :destroy
  
  has_many :followers, class_name: "Follower", foreign_key: :following_id, dependent: :destroy
  has_many :user_followers, through: :followers, source: :user

  has_many :followings, class_name: "Follower", foreign_key: :user_id, dependent: :destroy
  has_many :user_followings, through: :followings, source: :following

  def fall_asleep?
    sleep_histories.active.exists?
  end
end
