require 'rails_helper'

RSpec.describe Follower, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:following) }
  end

  describe 'validations' do
    let!(:follower) {create(:follower)}
    it { should validate_uniqueness_of(:user_id).scoped_to(:following_id) }
  end
end
