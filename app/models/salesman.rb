class Salesman < ApplicationRecord
  has_many :routes
  has_many :visits, through: :routes
  has_many :customers, through: :visits
  has_many :goals

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
    data = send("data_#{type}", date, 'visits') # remove visits that hasn't satisfaction_questionary
    all_percents = data.map do |visit|
      sq = visit.satisfaction_questionary
      return unless sq

      sq.accomplishment_percent
    end.compact
    return 0 if all_percents.size.zero?

    all_percents.sum / all_percents.size
  end

  def traffic_light_for(type, date, percent)
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
end
