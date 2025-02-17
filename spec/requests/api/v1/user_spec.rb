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

  path '/api/v1/users/{id}/fall_asleep' do
    post 'Fall asleep' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      response '201', 'Sleep history created' do
        let(:id) { create(:user).id }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 999 }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let!(:user) { create(:user) }
        let!(:sleep_history) { create(:sleep_history, :active, user: user) }
        let(:id) { user.id }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/wake_up' do
    post 'Wake up' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      response '200', 'OK' do
        let!(:user) { create(:user) }
        let!(:sleep_history) { create(:sleep_history, :active, user: user) }
        let(:id) { user.id }
        run_test!
      end

      response '400', 'Not found' do
        let!(:user) { create(:user) }
        let!(:sleep_history) { create(:sleep_history, user: user) }
        let(:id) { user.id }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 999 }
        run_test!
      end
    end
  end
end
