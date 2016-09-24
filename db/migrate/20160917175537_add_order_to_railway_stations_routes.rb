class AddOrderToRailwayStationsRoutes < ActiveRecord::Migration
  def change
    add_column :railway_stations_routes, :position, :integer, default: 1
  end
end
