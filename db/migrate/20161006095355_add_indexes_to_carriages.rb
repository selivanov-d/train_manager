class AddIndexesToCarriages < ActiveRecord::Migration
  def change
    add_index :carriages, :train_id
    add_index :carriages, :type
  end
end
