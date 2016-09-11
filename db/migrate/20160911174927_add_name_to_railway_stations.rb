class AddNameToRailwayStations < ActiveRecord::Migration
  def change
    add_column :railway_stations, :name, :string, null: false
  end
end
