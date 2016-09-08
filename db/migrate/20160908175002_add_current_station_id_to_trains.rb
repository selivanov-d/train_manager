class AddCurrentStationIdToTrains < ActiveRecord::Migration
  def change
    add_column :trains, :current_station_id, :integer
  end
end
