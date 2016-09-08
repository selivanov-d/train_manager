class AddRouteIdToTrains < ActiveRecord::Migration
  def change
    add_column :trains, :route_id, :integer
  end
end
