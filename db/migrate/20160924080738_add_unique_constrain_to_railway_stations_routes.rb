class AddUniqueConstrainToRailwayStationsRoutes < ActiveRecord::Migration
  def change
    add_index :railway_stations_routes, [:route_id, :railway_station_id], unique: true, name: 'index_route_station'
  end
end
