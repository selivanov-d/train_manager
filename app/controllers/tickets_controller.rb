class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :destroy]

  def index
    @tickets = current_user.tickets
  end

  def show
  end

  def create
    @ticket = Ticket.new(train_id: params[:train_id], departure_station_id: params[:departure_station_id], arrival_station_id: params[:arrival_station_id])

    current_user.tickets << @ticket

    redirect_to @ticket, notice: 'Билет создан!'
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Билет удалён!'
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
