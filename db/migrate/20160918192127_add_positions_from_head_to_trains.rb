class AddPositionsFromHeadToTrains < ActiveRecord::Migration
  def change
    add_column :trains, :position_from_head, :boolean, default: true, null: false
  end
end
