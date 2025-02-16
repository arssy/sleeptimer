class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, limit: 100

      t.timestamps
    end
  end
end
