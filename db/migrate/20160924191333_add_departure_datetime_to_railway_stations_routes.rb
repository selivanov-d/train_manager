class AddDepartureDatetimeToRailwayStationsRoutes < ActiveRecord::Migration
  def change
    add_column :railway_stations_routes, :departure_datetime, :datetime
  end
end
