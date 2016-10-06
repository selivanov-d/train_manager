class TicketsMailer < ApplicationMailer
  def ticket_bought_notification(user, ticket)
    @user = user
    @ticket = ticket

    mail(to: user.email, subject: t('tickets_mailer.ticket_bought_notification.mail_title'))
  end

  def ticket_canceled_notification(user, ticket)
    @user = user
    @ticket = ticket

    mail(to: user.email, subject: t('tickets_mailer.ticket_bought_notification.mail_title'))
  end
end
