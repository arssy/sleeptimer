FactoryBot.define do
  factory :sleep_history do
    user
    sleep_time { Time.zone.parse("2025-02-16 20:00:00") }
    wake_up_time { Time.zone.parse("2025-02-17 04:00:00") }
    sleep_duration { wake_up_time - sleep_time }
  end
end
