class Follower < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: "User", foreign_key: :following_id

  validates :user_id, uniqueness: {scope: :following_id}

  def follower_name
    user&.name
  end

  def following_name
    following&.name
  end
end
