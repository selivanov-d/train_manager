class AddPositionToCarriages < ActiveRecord::Migration
  def change
    add_column :carriages, :position, :integer
  end
end
