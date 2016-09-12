class AddNameToRailwayStations < ActiveRecord::Migration
  def change
    add_column :railway_stations, :name, :string
    change_column_null :railway_stations, :name, false
  end
end
