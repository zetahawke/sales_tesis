class Goal < ApplicationRecord
  belongs_to :salesman

  class << self
    def by_month(month = Date.current.month)
      where('EXTRACT(MONTH FROM goals.created_at) = ?', month)
    end

    def by_day(day = Date.current.day)
      where('EXTRACT(DAY FROM goals.created_at) = ?', day)
    end

    def by_year(year = Date.current.year)
      where('EXTRACT(YEAR FROM goals.created_at) = ?', year)
    end
  end

  def period
    case type_of_criteria
    when 'daily' then created_at.strftime('%d-%m-%Y')
    when 'monthly' then created_at.strftime('%m-%Y')
    when 'yearly' then created_at.strftime('%Y')
    else
      'indefinido'
    end
  end

  def traffic_light_color(percent_calculated)
    value_to_compare_against = criteria_value.try(:to_i)
    medium = value_to_compare_against / 2
    if percent_calculated < medium
      'red'
    elsif percent_calculated >= medium && percent_calculated < value_to_compare_against
      'yellow'
    elsif percent_calculated >= value_to_compare_against
      'green'
    else
      'red'
    end
  end
end
