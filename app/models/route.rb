class Route < ActiveRecord::Base
  validates :name, presence: true

  has_many :trains
  has_many :railway_stations_routes
  has_many :railway_stations, through: :railway_stations_routes

  validate :count_station

  def count_station
    errors.add(:base, 'Route must contain at least 2 stations') if railway_stations.size < 2
  end
end
