class Salesman < ApplicationRecord
  has_many :routes, dependent: :destroy
  has_many :visits, through: :routes, dependent: :destroy
  has_many :customers, through: :visits
  has_many :goals, dependent: :destroy
  has_many :money_goals, dependent: :destroy
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
    evaluation_percent = current_media_percent(type, date)
    sales_percent = current_sales_percent(type, date)
    {
      name => (((evaluation_percent > 100 ? 100 : evaluation_percent) || 0) * 0.4) + (((sales_percent > 100 ? 100 : sales_percent) || 0) * 0.6)
    }
  end

  def show_current_metrics(type, date)
    date = date.try(:to_date)
    evaluation_percent = current_media_percent(type, date)
    sales_percent = current_sales_percent(type, date)
    {
      'ventas' => ((sales_percent > 100 ? 100 : sales_percent) || 0),
      'evaluaciones' => ((evaluation_percent > 100 ? 100 : evaluation_percent) || 0),
      'promedio' => (((evaluation_percent > 100 ? 100 : evaluation_percent) || 0) * 0.4) + (((sales_percent > 100 ? 100 : sales_percent) || 0) * 0.6)
    }
  end

  def current_media_percent(type, date)
    return 0 if type.blank? || date.blank?

    data = send("data_#{type}", date.try(:to_date), 'visits')
    all_percents = data.map do |visit|
      sq = visit.satisfaction_questionary
      next unless sq

      sq.accomplishment_percent
    end.compact
    return 0 if all_percents.size.zero?

    all_percents.sum / all_percents.size
  end

  def current_sales_percent(type, date)
    return 0 if type.blank? || date.blank?
    
    money_goal = send("data_#{type}", date.try(:to_date), 'money_goals').where(type_of_criteria: type).last
    return 0 if money_goal.blank?
    
    data = send("data_#{type}", date, 'visits')
    sales_amount = data.sum { |dt| dt.sale_amount }

    (100.0 / (money_goal.amount.try(:to_f) || 0)) * sales_amount.try(:to_f)
  end

  def traffic_light_for(type, date, type_of_criteria = 'goals')
    return 'red' if type.blank? || date.blank?
    
    goal = send("data_#{type}", date.try(:to_date), type_of_criteria).where(type_of_criteria: type).last
    return 'red' unless goal
    
    percent = type_of_criteria == 'goals' ? current_media_percent(type, date) : current_sales_percent(type, date)
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
    update_columns(private_token: token)
  end

  def send_notification
    return unless email

    NotificationMailer.customer_visits_access(self, public_visits_url).deliver_now
  rescue StandardError => e
    puts e.message
  end

  def public_visits_url
    "#{Rails.configuration.public_url}/public/salesmen/visits?token=#{private_token}"
  end

  def amount_of_sales(type, date)
    countable_visits = send("data_#{type}", date&.to_date, 'visits')
    countable_visits.blank? ? 0 : countable_visits.sum(&:sale_amount)
  end
end
