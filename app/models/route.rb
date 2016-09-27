class Route < ActiveRecord::Base
  # REVIEW: здесь и в других моделях по уму надо бы сделать запрет на удаление маршрута если на нём есть поезда,
  # но, думаю, это уже сильно за гранью учебного проекта.
  has_many :trains, dependent: :nullify
  has_many :railway_stations_routes, dependent: :destroy
  has_many :railway_stations, through: :railway_stations_routes

  validates :name, presence: { message: 'У маршрута должно быть название' }
  validate :count_station

  def count_station
    errors.add(:base, 'Маршрут должен состоять как минимум из одной станции!') if railway_stations.size < 2
  end

  def station_in_route(station_id)
    railway_stations_routes.where('railway_station_id = ? and route_id = ?', station_id, id).first
  end
end
