class Search
  include ActiveModel::Model

  attr_accessor :departure_station_id, :arrival_station_id, :result

  validate :departure_and_arrival_station_must_not_be_same

  def make_search
    routes_with_departure_station = RailwayStation.find(departure_station_id).routes.to_a
    routes_with_arrival_station = RailwayStation.find(arrival_station_id).routes.to_a

    routes_with_both_stations = routes_with_departure_station & routes_with_arrival_station

    routes_with_both_stations.inject([]) do |trains, route|
      departure_station_in_route = route.station_in_route(departure_station_id)
      arrive_station_in_route = route.station_in_route(arrival_station_id)

      if departure_station_in_route.departure_datetime.present? && arrive_station_in_route.arrival_datetime.present?
        route.trains.each do |train|
          trains << train
        end
      end

      trains
    end
  end

  private

  def departure_and_arrival_station_must_not_be_same
    if departure_station_id == arrival_station_id
      errors.add(:base, 'Начальная и конечная станции должны различаться!')
    end
  end
end
