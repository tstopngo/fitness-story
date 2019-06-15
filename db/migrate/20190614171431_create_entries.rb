class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.datetime :date_time
      t.integer :workout_calories
      t.integer :food_calories
      t.integer :net_calories
      t.string :food
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
