class CreateSleepHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamp :sleep_time
      t.timestamp :wake_up_time
      t.integer :sleep_duration

      t.timestamps
    end
  end
end
