module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, only: %i[show fall_asleep]

      def show
        render jsonapi: @user, include: :sleep_histories, class: {User: UserSerializer, SleepHistory: SleepHistorySerializer}
      end

      def fall_asleep
        sleep_history = @user.sleep_histories.build(sleep_time: Time.zone.now)
        if sleep_history.save
          render jsonapi: sleep_history, class: {SleepHistory: SleepHistorySerializer}, status: :created
        else
          render jsonapi_errors: sleep_history.errors, status: :unprocessable_entity
        end
      end

      private
        def set_user
          @user = User.find(params[:id])
        end
    end
  end
end
