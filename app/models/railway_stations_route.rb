class RailwayStationsRoute < ActiveRecord::Base
  belongs_to :railway_station
  belongs_to :route

  before_create :assign_position

  validates :route_id, uniqueness: { scope: :railway_station_id }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def assign_position
    max_position = self.class.where(route_id: route_id).maximum('position')
    max_position ||= 0
    self.position = max_position + 1
  end
end
