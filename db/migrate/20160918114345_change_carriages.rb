class ChangeCarriages < ActiveRecord::Migration
  def change
    remove_column :carriages, :type_id

    add_column :carriages, :type, :string

    add_column :carriages, :side_bottom_seats, :integer, default: 0
    add_column :carriages, :side_upper_seats, :integer, default: 0
    add_column :carriages, :seating_only_seats, :integer, default: 0
  end
end
