class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :train
  belongs_to :departure_station, class_name: 'RailwayStation'
  belongs_to :arrival_station, class_name: 'RailwayStation'

  after_create :send_ticket_bought_notification
  after_destroy :send_ticket_canceled_notification

  private

  def send_ticket_bought_notification
    TicketsMailer.ticket_bought_notification(self.user, self).deliver_now
  end

  def send_ticket_canceled_notification
    TicketsMailer.ticket_canceled_notification(self.user, self).deliver_now
  end
end
