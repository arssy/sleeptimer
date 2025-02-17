class User < ApplicationRecord
  has_many :sleep_histories, dependent: :destroy
  
  has_many :followers, class_name: "Follower", foreign_key: :following_id, dependent: :destroy
  has_many :user_followers, through: :followers, source: :user

  has_many :followings, class_name: "Follower", foreign_key: :user_id, dependent: :destroy
  has_many :user_followings, through: :followings, source: :following

  def fall_asleep?
    sleep_histories.active.exists?
  end

  def following_sleep_histories
    user_followings.select("sleep_histories.*, users.name")
                   .joins(:sleep_histories)
                   .where("sleep_histories.created_at >= ?", 1.week.ago.beginning_of_week)
                   .order("sleep_histories.sleep_duration ASC")
  end
end
