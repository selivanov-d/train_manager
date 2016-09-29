class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  def index
    @routes = Route.all
  end

  def show
  end

  def new
    @route = Route.new
  end

  def edit
  end

  def create
    @route = Route.new(route_params)

    if @route.save
      redirect_to @route, notice: 'Маршрут создан!'
    else
      flash.alert = get_errors_as_array_of_strings_for(@route)
      render :new
    end
  end

  def update
    if @route.update(route_params)
      redirect_to @route, notice: 'Маршрут обновлён'
    else
      flash.alert = get_errors_as_array_of_strings_for(@route)
      render :edit
    end
  end

  def destroy
    @route.destroy
    redirect_to routes_url, notice: 'Маршрут удалён!'
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:name, railway_station_ids: [])
  end
end
