module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, only: %i[show]

      def show
        render jsonapi: @user, include: :sleep_histories, class: {User: UserSerializer, SleepHistory: SleepHistorySerializer}
      end

      private
        def set_user
          @user = User.find(params[:id])
        end
    end
  end
end
