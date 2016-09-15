class CreateCarriages < ActiveRecord::Migration
  def change
    create_table :carriages do |t|
      t.integer :type_id, null: false
      t.integer :train_id
      t.integer :upper_seats, null: false, default: 0
      t.integer :bottom_seats, null: false, default: 0

      t.timestamps null: false
    end
  end
end
