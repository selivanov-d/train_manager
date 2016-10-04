class Admin::RailwayStationsController < Admin::BaseController
  include DateHelper

  before_action :set_railway_station, only: [:show, :edit, :update, :destroy, :update_position]
  before_action :set_route_by_route_id, only: [:update_position, :update_arrival_datetime, :update_departure_datetime]
  before_action :set_railway_station_by_station_id, only: [:update_arrival_datetime, :update_departure_datetime]
  before_action :set_station_route, only: [:update_position, :update_arrival_datetime, :update_departure_datetime]

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
      redirect_to admin_railway_station_path(@railway_station), notice: t('.success_notice')
    else
      render :new
    end
  end

  def update
    if @railway_station.update(railway_station_params)
      redirect_to admin_railway_station_path(@railway_station), notice: t('.success_notice')
    else
      render :edit
    end
  end

  def destroy
    @railway_station.destroy
    redirect_to admin_railway_stations_url, notice: t('.success_notice')
  end

  def update_position
    if @station_route.update(position: params[:position])
      redirect_to admin_route_path(@route), notice: t('.success_notice')
    else
      redirect_to admin_route_path(@route), alert: t('.fail_alert')
    end
  end

  def update_arrival_datetime
    date = time_object_from_params_from_datetime_params(params[:arrival_datetime])

    if !date
      redirect_to admin_route_path(@route), alert: t('.wrong_datetime_format')
    else
      if @station_route.update(arrival_datetime: date)
        redirect_to admin_route_path(@route), notice: t('.success_notice')
      else
        redirect_to admin_route_path(@route), alert: t('.fail_alert')
      end
    end
  end

  def update_departure_datetime
    date = time_object_from_params_from_datetime_params(params[:departure_datetime])

    if !date
      redirect_to admin_route_path(@route), alert: t('.wrong_datetime_format')
    else
      if @station_route.update(departure_datetime: date)
        redirect_to admin_route_path(@route), notice: t('.success_notice')
      else
        redirect_to admin_route_path(@route), alert: t('.fail_alert')
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

  def set_route_by_route_id
    @route = Route.find(params[:route_id])
  end

  def set_railway_station_by_station_id
    @railway_station = RailwayStation.find(params[:station_id])
  end

  def set_station_route
    @station_route = @railway_station.station_route(@route)
  end
end
