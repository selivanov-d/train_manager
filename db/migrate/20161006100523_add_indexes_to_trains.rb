class AddIndexesToTrains < ActiveRecord::Migration
  def change
    add_index :trains, :route_id
    add_index :trains, :current_station_id
  end
end
