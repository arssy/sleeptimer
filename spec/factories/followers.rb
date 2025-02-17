FactoryBot.define do
  factory :follower do
    user
    following { create(:user) }
  end
end
