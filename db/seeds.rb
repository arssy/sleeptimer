# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Generate users

ActiveRecord::Base.transaction do 
  users = FactoryBot.create_list(:user, 2)
  user_ids = users.pluck(:id)
  dates = (Time.zone.now.beginning_of_month.to_date..Time.zone.now.to_date)

  users.each do |user|
    # Generate user sleep histories for this month
    sleep_histories = []
    dates.each do |date|
      sleep_time = Time.at(rand(date.beginning_of_day.to_i..date.end_of_day.to_i))
      wake_up_time = Time.at(rand(sleep_time.to_i..(sleep_time + 12.hours).to_i))
      sleep_histories << {sleep_time: sleep_time, wake_up_time: wake_up_time, sleep_duration: (wake_up_time - sleep_time).to_i}
    end
    user.sleep_histories.create(sleep_histories)

    # Generate followers
    other_user_ids = user_ids - [user.id]
    total_followers = rand(0..user_ids.size)
    followers = other_user_ids.sample(total_followers).map{|x| {user_id: x}}
    user.followers.create(followers)
  end
end