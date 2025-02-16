class User < ApplicationRecord
  has_many :sleep_histories, dependent: :destroy
end
