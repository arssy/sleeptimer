FactoryBot.define do
  factory :follower do
    user { create(:user) }
    following { create(:user) }
  end
end
