class RailwayStationsController < ApplicationController
  # REVIEW: можно ли использовать хэлперы в контроллере или только в модели?
  include DateHelper

  before_action :set_railway_station, only: [:show, :edit, :update, :destroy, :update_position]

  def index
    @railway_stations = RailwayStation.all
  end

  def show
  end

  def new
    @railway_station = RailwayStation.new
  end

  def edit
  end

  def create
    @railway_station = RailwayStation.new(railway_station_params)

    if @railway_station.save
      redirect_to @railway_station, notice: 'Станция создана!'
    else
      flash.alert = get_errors_as_array_of_strings_for(@railway_station)
      render :new
    end
  end

  def update
    if @railway_station.update(railway_station_params)
      redirect_to @railway_station, notice: 'Станция обновлена'
    else
      flash.alert = get_errors_as_array_of_strings_for(@railway_station)
      render :edit
    end
  end

  def destroy
    @railway_station.destroy
    redirect_to railway_stations_url, notice: 'Станция удалена!'
  end

  def update_position
    @route = Route.find(params[:route_id])

    station_route = @railway_station.station_route(@route)

    if station_route.update(position: params[:position])
      redirect_to @route, notice: 'Позиция обновлена!'
    else
      flash.alert = get_errors_as_array_of_strings_for(station_route)
      redirect_to @route
    end
  end

  def update_arrival_datetime
    @route = Route.find(params[:route_id])
    @railway_station = RailwayStation.find(params[:station_id])

    station_route = @railway_station.station_route(@route)

    # REVIEW: не понял как сделать лучше. Неприлично много времени потратил на то, чтобы заставить работать хэлпер для даты и времени.
    # Т.е. как сделать так, чтобы данные из набора селектов превращались в формат, пригодный для хранения в БД?
    date = time_object_from_params_from_datetime_params(params[:arrival_datetime])

    if !date
      flash.alert = station_route.errors.add(:arrival_datetime, 'Незаполена дата прибытия!')
      redirect_to @route
    else
      if station_route.update(arrival_datetime: date)
        redirect_to @route, notice: 'Время прибытия обновлено!'
      else
        flash.alert = get_errors_as_array_of_strings_for(station_route)
        redirect_to @route
      end
    end
  end

  def update_departure_datetime
    @route = Route.find(params[:route_id])
    @railway_station = RailwayStation.find(params[:station_id])

    station_route = @railway_station.station_route(@route)

    date = time_object_from_params_from_datetime_params(params[:departure_datetime])

    if !date
      flash.alert = station_route.errors.add(:departure_datetime, 'Незаполена дата отправления!')
      redirect_to @route
    else
      if station_route.update(departure_datetime: date)
        redirect_to @route, notice: 'Время отправления обновлено!'
      else
        flash.alert = get_errors_as_array_of_strings_for(station_route)
        redirect_to @route
      end
    end
  end

  private

  def set_railway_station
    @railway_station = RailwayStation.find(params[:id])
  end

  def railway_station_params
    params.require(:railway_station).permit(:name)
  end
end
