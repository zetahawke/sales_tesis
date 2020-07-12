class Salesman < ApplicationRecord
  has_many :routes
  has_many :visits, through: :routes
  has_many :customers, through: :visits

  class << self
    def all_media_percent(type, date)
      obj = {}
      date = date.try(:to_date)
      where('').map do |salesman|
        obj.merge!({ salesman.name => salesman.current_media_percent(type, date) })
      end
      obj
    end
  end

  def current_media_percent(type, date)
    data = send("visit_data_#{type}", date)
    all_percents = data.map do |visit|
      visit.satisfaction_questionary.accomplishment_percent
    end
    return 0 if all_percents.size.zero?

    all_percents.sum / all_percents.size
  end

  def visit_data_daily(date)
    visits.by_year(date.year).by_month(date.month).by_day(date.day)
  end

  def visit_data_monthly(date)
    visits.by_year(date.year).by_month(date.month)
  end

  def visit_data_yearly(date)
    visits.by_year(date.year)
  end
end
