module Api
  module V1
    class UserSerializer < JSONAPI::Serializable::Resource
      type 'user'
      attributes :name

      has_many :sleep_histories do 
        data do 
          @object.sleep_histories.newest
        end

        meta do
          { count: @object.sleep_histories.size }
        end
      end
    end
  end
end