class RenameTicketsFields < ActiveRecord::Migration
  def change
    rename_column :tickets, :start_station_id, :departure_station_id
    rename_column :tickets, :finish_station_id, :arrival_station_id
  end
end
