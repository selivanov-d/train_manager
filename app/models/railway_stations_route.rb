class RailwayStationsRoute < ActiveRecord::Base
  belongs_to :railway_station
  belongs_to :route

  before_validation :before_validation_assign_position, on: :create

  validates :route_id, uniqueness: { scope: :railway_station_id }
  validates :position, numericality: {
    only_integer: true,
    greater_than: 0
  }

  validates :position, uniqueness: {
    scope: :route_id
  }

  validates :arrival_datetime, timeliness: {
    type: :datetime,
    allow_blank: true
  }

  validates :departure_datetime, timeliness: {
    type: :datetime,
    allow_blank: true
  }

  validates :arrival_datetime, timeliness: {
    after: :now,
  }, allow_blank: true

  validates :departure_datetime, timeliness: {
    after: :now,
  }, allow_blank: true

  validates :arrival_datetime, timeliness: {
    before: :departure_datetime,
    if: -> (railway_stations_route) do
      railway_stations_route.departure_datetime.present? && railway_stations_route.departure_datetime.present?
    end,
  }

  private

  def before_validation_assign_position
    max_position = self.class.where(route_id: route_id).maximum('position')
    max_position ||= 0
    self.position = max_position + 1
  end
end
