module RailwayStationsHelper
  def station_name_by_id(station_id)
    RailwayStation.select(:name).find(station_id).name
  end
end
