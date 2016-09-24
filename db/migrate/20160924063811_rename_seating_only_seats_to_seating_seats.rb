class RenameSeatingOnlySeatsToSeatingSeats < ActiveRecord::Migration
  def change
    rename_column :carriages, :seating_only_seats, :seating_seats
  end
end
