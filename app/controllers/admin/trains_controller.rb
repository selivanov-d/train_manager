class Admin::TrainsController < Admin::BaseController
  before_action :set_train, only: [:show, :edit, :update, :destroy]

  def index
    @trains = Train.all
  end

  def show
  end

  def new
    @train = Train.new
  end

  def edit
  end

  def create
    @train = Train.new(train_params)

    if @train.save
      redirect_to admin_train_path(@train), notice: t('.success_notice')
    else
      render :new
    end
  end

  def update
    if @train.update(train_params)
      redirect_to admin_train_path(@train), notice: t('.success_notice')
    else
      render :edit
    end
  end

  def destroy
    @train.destroy
    redirect_to admin_trains_url, notice: t('.success_notice')
  end

  def update_name
    train = Train.find(params[:id])

    train.number = ActionController::Base.helpers.sanitize(params[:name].squish)

    respond_to do |format|
      if train.save
        format.json { render nothing: true, status: :ok}
      else
        format.json { render json: train.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_train
    @train = Train.find(params[:id])
  end

  def train_params
    params.require(:train).permit(:number, :route_id, :position_from_head)
  end
end
