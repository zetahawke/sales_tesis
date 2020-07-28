class Salesman < ApplicationRecord
  has_many :routes
  has_many :visits, through: :routes
  has_many :customers, through: :visits
  has_many :goals
  after_create :generate_private_token
  after_create :send_notification

  class << self
    def all_media_percent(type, date)
      obj = {}
      date = date.try(:to_date)
      where('').map do |salesman|
        obj.merge!(salesman.current_metrics(type, date))
      end
      obj
    end
  end

  def current_metrics(type, date)
    date = date.try(:to_date)
    {
      name => current_media_percent(type, date)
    }
  end

  def current_media_percent(type, date)
    return 0 if type.blank? || date.blank?

    data = send("data_#{type}", date, 'visits')
    all_percents = data.map do |visit|
      sq = visit.satisfaction_questionary
      next unless sq

      sq.accomplishment_percent
    end.compact
    return 0 if all_percents.size.zero?

    all_percents.sum / all_percents.size
  end

  def traffic_light_for(type, date, percent)
    return 'red' if type.blank? || date.blank? || percent.blank?

    goal = send("data_#{type}", date.try(:to_date), 'goals').where(type_of_criteria: type).last
    return 'red' unless goal

    goal.traffic_light_color(percent)
  end

  def data_daily(date, type_of_data)
    send(type_of_data).by_year(date.year).by_month(date.month).by_day(date.day)
  end

  def data_monthly(date, type_of_data)
    send(type_of_data).by_year(date.year).by_month(date.month)
  end

  def data_yearly(date, type_of_data)
    send(type_of_data).by_year(date.year)
  end

  def generate_private_token
    token = Devise.friendly_token
    update_columns(public_token: token)
  end

  def send_notification
    return unless email

    NotificationMailer.customer_visits_access(self, public_visits_url).deliver_now
  rescue StandardError => e
    puts e.message
  end

  def public_visits_url
    "#{Rails.configuration.public_url}/public/visits?public_token=#{public_token}"
  end
end
