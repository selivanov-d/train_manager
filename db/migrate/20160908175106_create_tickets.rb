class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :train_id, null: false
      t.integer :user_id, null: false
      t.integer :start_station_id, null: false
      t.integer :finish_station_id, null: false

      t.timestamps null: false
    end
  end
end
