module Api
  module V1
    class FollowerSerializer < JSONAPI::Serializable::Resource
      type 'follower'
      attributes :follower_name, :following_name
    end
  end
end