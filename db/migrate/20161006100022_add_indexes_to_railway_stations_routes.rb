class AddIndexesToRailwayStationsRoutes < ActiveRecord::Migration
  def change
    add_index :railway_stations_routes, :route_id
    add_index :railway_stations_routes, :railway_station_idTi
  end
end
