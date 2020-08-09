class Visit < ApplicationRecord
  belongs_to :customer
  belongs_to :route
  has_one :satisfaction_questionary
  has_one :salesman, through: :route
  has_one :excuse

  accepts_nested_attributes_for :excuse

  enum status: { created: 0, accomplished: 1, not_accomplished: 2 }

  class << self
    def by_month(month = Date.current.month)
      where('EXTRACT(MONTH FROM visits.created_at) = ?', month)
    end

    def by_day(day = Date.current.day)
      where('EXTRACT(DAY FROM visits.created_at) = ?', day)
    end

    def by_year(year = Date.current.year)
      where('EXTRACT(YEAR FROM visits.created_at) = ?', year)
    end
  end

  def match_name
    "#{salesman.name} visita a #{customer.name}"
  end
end
