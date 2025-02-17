class CreateFollowers < ActiveRecord::Migration[8.0]
  def change
    create_table :followers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :following, null: false, foreign_key: {to_table: "users"}

      t.timestamps
    end
  end
end
