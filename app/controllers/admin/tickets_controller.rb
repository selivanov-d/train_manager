class Admin::TicketsController < Admin::BaseController
  before_action :set_ticket, only: [:show, :destroy]

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def destroy
    @ticket.destroy
    redirect_to admin_tickets_url, notice: t('.success_notice')
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
