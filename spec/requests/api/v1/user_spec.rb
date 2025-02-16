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

end
