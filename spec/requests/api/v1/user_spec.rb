require 'swagger_helper'

RSpec.describe 'API V1 - User', type: :request do
  path '/api/v1/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      response '200', 'User found' do
        let(:id) { create(:user).id }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 999 }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/following_sleep_histories' do
    get 'Retrieves sleep histories from user followed by current user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      response '200', 'OK' do
        let(:id) { create(:user).id }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 999 }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/fall_asleep' do
    post 'Fall asleep' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      let!(:user) { create(:user) }
      let(:id) { user.id }
      
      response '201', 'Sleep history created' do
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 999 }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let!(:sleep_history) { create(:sleep_history, :active, user: user) }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/wake_up' do
    post 'Wake up' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      let!(:user) { create(:user) }
      let(:id) { user.id }

      response '200', 'OK' do
        let!(:sleep_history) { create(:sleep_history, :active, user: user) }
        run_test!
      end

      response '400', 'Bad request' do
        let!(:sleep_history) { create(:sleep_history, user: user) }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 999 }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/follow/{following_id}' do
    post 'Follow' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, example: 1, required: true
      parameter name: :following_id, in: :path, type: :integer, example: 2, required: true

      let(:user) { create(:user) }
      let(:following) { create(:user) }
      let(:id) { user.id }
      let(:following_id) { following.id }

      response '200', 'OK' do
        run_test!
      end

      response '400', 'Bad request' do
        let!(:follower) { create(:follower, user: user, following: following) }
        run_test!
      end

      response '404', 'Not found' do
        let(:following_id) { 999 }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/unfollow/{following_id}' do
    post 'Unfollow' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, example: 1, required: true
      parameter name: :following_id, in: :path, type: :integer, example: 2, required: true

      let(:user) { create(:user) }
      let(:following) { create(:user) }
      let(:another_user) { create(:user) }
      let(:id) { user.id }
      let(:following_id) { following.id }

      before do 
        post "/api/v1/users/#{user.id}/follow/#{following.id}"
      end

      response '204', 'No Content' do
        run_test!
      end

      response '400', 'Bad request' do
        let(:following_id) { another_user.id }
        run_test!
      end

      response '404', 'Not found' do
        let(:following_id) { 99 }
        run_test!
      end
    end
  end
end
