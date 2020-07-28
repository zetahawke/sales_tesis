class NotificationMailer < ApplicationMailer
  default from: 'Evares <post-sale@evares.com>'

  def customer_questionary(customer, visit, sq)
    return if customer.email.blank?

    @customer, @visit, @sq = [customer, visit, sq]
    mail(to: [customer.email], subject: "Encuesta de satisfacción #{Date.current}")
  end

  def customer_visits_access(customer, public_url)
    return if customer.email.blank?

    @customer, @public_url = [customer, public_url]
    mail(to: [customer.email], subject: "Link de acceso #{Date.current}")
  end

  def salesman_visits_access(salesman, public_url)
    return if salesman.email.blank?

    @salesman, @public_url = [salesman, public_url]
    mail(to: [salesman.email], subject: "Link de acceso #{Date.current}")
  end
end