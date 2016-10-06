class Route < ActiveRecord::Base
  has_many :trains, dependent: :nullify
  has_many :railway_stations_routes, dependent: :destroy
  has_many :railway_stations, through: :railway_stations_routes

  validates :name, presence: true
  validate :count_station

  def count_station
    errors.add(:base, :not_enough_stations) if railway_stations.size < 2
  end

  def station_in_route(station_id)
    railway_stations_routes.where('railway_station_id = ? and route_id = ?', station_id, id).first
  end
end
