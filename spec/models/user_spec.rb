require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:sleep_histories) }
    it { should have_many(:followers) }
    it { should have_many(:user_followers) }
    it { should have_many(:followings) }
    it { should have_many(:user_followings) }
  end

  describe '.fall_asleep?' do 
    let (:user) { create(:user) }

    context "when user have active sleep timer" do 
      let! (:sleep_history) { create(:sleep_history, :active, user: user) }
      it "should return true" do 
        expect(user.fall_asleep?).to eq(true)
      end
    end

    context "when user doesn't have an active sleep timer" do 
      it "should return false" do 
        expect(user.fall_asleep?).to eq(false)
      end
    end
  end
end
