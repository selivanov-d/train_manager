class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket_and_check_its_owner, only: [:show, :destroy]

  def index
    @tickets = current_user.tickets
  end

  def show
  end

  def create
    @ticket = Ticket.new(train_id: params[:train_id], departure_station_id: params[:departure_station_id], arrival_station_id: params[:arrival_station_id])

    current_user.tickets << @ticket

    redirect_to @ticket, notice: t('.success_notice')
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: t('.success_notice')
  end

  private

  def set_ticket_and_check_its_owner
    @ticket = current_user.tickets.find(params[:id])
    redirect_to root_path, alert: 'Доступ запрещён!' unless @ticket.user == current_user
  end
end
