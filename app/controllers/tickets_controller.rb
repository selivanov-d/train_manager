class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = Ticket.new

    @train_id = params[:train_id]
    @start_station_id = params[:start_station_id]
    @finish_station_id = params[:finish_station_id]

    render :new
  end

  def create
    @ticket = Ticket.new(ticket_params)

    user = User.find_or_initialize_by(first_name: params[:buyer_first_name], family_name: params[:buyer_second_name])

    if user.new_record?
      unless user.save
        flash.alert = get_errors_as_array_of_strings_for(user)
        render :new
      end
    end

    @ticket.user_id = user.id

    if @ticket.save
      redirect_to @ticket, notice: 'Билет создан!'
    else
      flash.alert = get_errors_as_array_of_strings_for(@ticket)
      render :new
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Билет удалён!'
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:train_id, :start_station_id, :finish_station_id)
  end
end
