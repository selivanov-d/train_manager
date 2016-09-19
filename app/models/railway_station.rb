class RailwayStation < ActiveRecord::Base
  has_many :trains, foreign_key: :current_station_id
  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes

  validates :name, presence: true

  scope :ordered, -> { joins(:railway_stations_routes).uniq.order('railway_stations_routes.position') }

  def position_in_route(route_id)
    railway_stations_routes.where(route_id: route_id, railway_station_id: id).first.position
  end
end
