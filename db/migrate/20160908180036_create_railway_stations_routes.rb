class CreateRailwayStationsRoutes < ActiveRecord::Migration
  def change
    create_table :railway_stations_routes do |t|
      t.belongs_to :route, null: false
      t.belongs_to :railway_station, null: false
    end
  end
end
