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
      where('EXTRACT(MONTH FROM visits.created_at) = ?', month).exclude_excused
    end

    def by_day(day = Date.current.day)
      where('EXTRACT(DAY FROM visits.created_at) = ?', day).exclude_excused
    end

    def by_year(year = Date.current.year)
      where('EXTRACT(YEAR FROM visits.created_at) = ?', year).exclude_excused
    end

    def exclude_excused
      # joins(:excuse).where(excuses: { valid_argument: false })
      left_outer_joins(:excuse).group("visits.id, excuses.valid_argument").having("(COUNT(excuses) = 0) OR (COUNT(excuses) > 0 AND excuses.valid_argument = ?)", false)
      # select do |visit|
      #   return true if visit.excuse.blank?
        
      #   !visit.excuse.valid_argument
      # end
    end

    def unquestioned
      left_outer_joins(:satisfaction_questionary).having("COUNT(satisfaction_questionaries.id) < 1").group("visits.id")
    end
  end

  def match_name
    "#{salesman.name} visita a #{customer.name}"
  end
end
