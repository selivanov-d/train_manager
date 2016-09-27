class TrainsController < ApplicationController
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
      redirect_to @train, notice: 'Поезд создан!'
    else
      flash.alert = get_errors_as_array_of_strings_for(@train)
      render :new
    end
  end

  def update
    if @train.update(train_params)
      redirect_to @train, notice: 'Поезд обновлён!'
    else
      flash.alert = get_errors_as_array_of_strings_for(@train)
      render :edit
    end
  end

  def destroy
    @train.destroy
    redirect_to trains_url, notice: 'Поезд удалён!'
  end

  private

  def set_train
    @train = Train.find(params[:id])
  end

  def train_params
    params.require(:train).permit(:number, :route_id, :position_from_head)
  end
end
