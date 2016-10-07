class Admin::RoutesController < Admin::BaseController
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
      redirect_to admin_route_path(@route), notice: t('.success_notice')
    else
      render :new
    end
  end

  def update
    if @route.update(route_params)
      redirect_to admin_route_path(@route), notice: t('.success_notice')
    else
      render :edit
    end
  end

  def destroy
    @route.destroy
    redirect_to admin_routes_path, notice: t('.success_notice')
  end

  def update_name
    route = Route.find(params[:id])

    route.name = ActionController::Base.helpers.sanitize(params[:name].squish)

    respond_to do |format|
      if route.save
        format.json { render nothing: true, status: :ok}
      else
        format.json { render json: route.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:name, railway_station_ids: [])
  end
end
