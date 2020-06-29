class NotificationMailer < ApplicationMailer
  default from: 'Evares <post-sale@evares.com>'

  def customer_questionary(customer, visit, sq)
    return if customer.email.blank?

    @customer, @visit, @sq = [customer, visit, sq]
    mail(to: [customer.email], subject: "Encuesta de satisfacción #{Date.current}")
  end
end