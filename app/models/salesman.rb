class Salesman < ApplicationRecord
  has_many :routes
  has_many :visits, through: :routes
  has_many :customers, through: :visits

  class << self
    def all_media_percent
      obj = {}
      where('').map do |salesman|
        obj.merge!({ salesman.name => salesman.current_media_percent })
      end
      obj
    end
  end

  def current_media_percent
    all_percents = visits.by_year.by_month.map do |visit|
      visit.satisfaction_questionary.accomplishment_percent
    end
    return 0 if all_percents.size.zero?

    all_percents.sum / all_percents.size
  end
end
