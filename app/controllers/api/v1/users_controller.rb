module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, only: %i[show fall_asleep wake_up follow]

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

      def wake_up
        sleep_history = @user.sleep_histories.active
        error_response(:bad_request, "You're already awake, Have a wonderful day!") and return unless sleep_history.exists?

        if sleep_history.last.update(wake_up_time: Time.zone.now)
          render jsonapi: sleep_history, class: {SleepHistory: SleepHistorySerializer}
        else
          render jsonapi_errors: sleep_history.errors, status: :unprocessable_entity
        end
      end

      def follow
        following_user = User.find(params[:following_id])
        following = @user.followings.find_or_initialize_by(following_id: params[:following_id])
        error_response(:bad_request, "You're already following this user") and return unless following.new_record?
        
        if following.save
          render jsonapi: following, class: {Follower: FollowerSerializer}
        else
          render jsonapi_errors: following.errors, status: :unprocessable_entity
        end
      end

      private
        def set_user
          @user = User.find(params[:id])
        end
    end
  end
end
