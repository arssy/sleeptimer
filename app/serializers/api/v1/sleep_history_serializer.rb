module Api
  module V1
    class SleepHistorySerializer < JSONAPI::Serializable::Resource
      type 'sleep_history'
      attributes :sleep_time, :wake_up_time, :sleep_duration
      
      attribute :formatted_duration do 
        hours = @object.sleep_duration / 3600
        minutes = (@object.sleep_duration % 3600) / 60
        seconds = (@object.sleep_duration % 3600) % 60
        format("%02d:%02d:%02d", hours, minutes, seconds)
      end
    end
  end
end