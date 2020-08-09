class Customer < ApplicationRecord
  has_many :visits
  after_create :generate_private_token
  after_create :send_notification

  def generate_private_token
    token = Devise.friendly_token
    update_columns(private_token: token)
  end

  def send_notification
    return unless email

    NotificationMailer.customer_visits_access(self, public_visits_url).deliver_now
  rescue StandardError => e
    puts e.message
  end

  def public_visits_url
    "#{Rails.configuration.public_url}/public/customers/visits?private_token=#{private_token}"
  end
end
