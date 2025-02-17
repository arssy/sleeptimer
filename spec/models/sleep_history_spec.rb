require 'rails_helper'

RSpec.describe SleepHistory, type: :model do
  # Test suite for associations
  describe 'associations' do
    it { should belong_to(:user) }
  end

  # Test suite for validations
  describe 'validations' do

    it { should validate_presence_of(:sleep_time) }

    describe 'create sleep history' do 
      let! (:user) { create(:user) }

      context 'when user already have an active timer' do
        let! (:active_sleep_history) { create(:sleep_history, :active, user: user) }

        it 'should return validation error' do 
          sleep_history = user.sleep_histories.create(sleep_time: Time.zone.now)
          expect(sleep_history.errors).not_to be_empty
        end
      end

      context 'when user doesn\'t have an active timer' do
        it 'should return created sleep history' do 
          sleep_history = user.sleep_histories.create(sleep_time: Time.zone.now)
          expect(sleep_history.id).not_to be_nil
        end
      end
    end

    describe 'update sleep history' do
      let!(:user) { create(:user) }
      let(:sleep_history) { create(:sleep_history, :active, user: user) }
      
      it 'should update updated_at' do 
        sleep_history.update(wake_up_time: Time.zone.now)
        expect(sleep_history.updated_at).not_to eq(sleep_history.created_at)
      end

      it 'should update wake_up_time' do 
        sleep_history.update(wake_up_time: Time.zone.now)
        expect(sleep_history.wake_up_time).not_to be_nil
      end

      it 'should update sleep_duration' do 
        sleep_history.update(wake_up_time: Time.zone.now)
        expect(sleep_history.sleep_duration).not_to be_nil
      end
    end
  end

  # Test suite for scopes
  describe 'scopes' do  
    let (:user) { create(:user) }

    describe '.newest' do
      before do 
        create_list(:sleep_history, 4, user: user)
      end

      it 'should retrieve user\'s sleep histories ordered by created_at (desc)' do
        newest_sleep_histories = user.sleep_histories.newest
        expect(newest_sleep_histories.first.created_at).to be > newest_sleep_histories.last.created_at
      end
    end

    describe '.active' do 
      let! (:active_sleep_history) { create(:sleep_history, :active, user: user) }
      let (:sleep_histories) { user.sleep_histories.active }

      it 'should return 1 record' do 
        expect(sleep_histories.size).to eq(1)
      end

      it 'should return the active sleep history' do 
        expect(sleep_histories.first.id).to eq(active_sleep_history.id)
      end
    end
  end
end
