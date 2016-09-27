class AddArrivalDatetimeToRailwayStationsRoutes < ActiveRecord::Migration
  def change
    add_column :railway_stations_routes, :arrival_datetime, :datetime
  end
end
