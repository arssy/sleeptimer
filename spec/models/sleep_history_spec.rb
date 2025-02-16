require 'rails_helper'

RSpec.describe SleepHistory, type: :model do
  # Test suite for associations
  describe 'associations' do
    it { should belong_to(:user) }
  end

  # Test suite for scopes
  describe 'scopes' do
    describe '.newest' do
      let (:user) { create(:user) }

      before do 
        create_list(:sleep_history, 4, user: user)
      end

      it 'should retrieve user\'s sleep histories ordered by created_at (desc)' do
        newest_sleep_histories = user.sleep_histories.newest
        expect(newest_sleep_histories.first.created_at).to be > newest_sleep_histories.last.created_at
      end
    end
  end
end
