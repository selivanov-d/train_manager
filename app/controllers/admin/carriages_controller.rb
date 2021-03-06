class Admin::CarriagesController < Admin::BaseController
  before_action :set_carriage, only: [:show, :edit, :update, :destroy]
  before_action :set_train, only: [:new, :create, :index]

  def index
    @carriages = @train.carriages
  end

  def show
    render :show, locals: { class_snake_case: @carriage.class_name_in_snake_case }
  end

  def new
    @carriage = Carriage.new
  end

  def edit
    render :edit, locals: { class_name: @carriage.class.name.demodulize.downcase }
  end

  def create
    @carriage = @train.carriages.new(carriage_params)

    if @carriage.save
      redirect_to admin_train_path(@train), notice: t('.success_notice')
    else
      render :new
    end
  end

  def update
    if @carriage.update(carriage_params)
      redirect_to admin_train_path(@carriage.train), notice: t('.success_notice')
    else
      render :edit, locals: { class_name: @carriage.class.to_s }
    end
  end

  def destroy
    @carriage.destroy
    redirect_to admin_train_carriages_path(@carriage.train), notice: t('.success_notice')
  end

  private

  def set_carriage
    @carriage = Carriage.find(params[:id])
  end

  def carriage_params
    base_allowed_params = [:type, :train_id, :position]

    received_carriage_params = params.require(:carriage)

    klass = received_carriage_params[:type].constantize

    type_specific_allowed_params =
      if Carriage::TYPES.include? klass
        klass::SEATS_TYPES_ATTRIBUTES_NAMES
      else
        raise ArgumentError
      end

    received_carriage_params.permit(base_allowed_params + type_specific_allowed_params)
  end

  def set_train
    @train = Train.find(params[:train_id])
  end
end
