class Visit < ApplicationRecord
  belongs_to :customer
  belongs_to :route, optional: true
  has_one :satisfaction_questionary, dependent: :destroy
  has_one :salesman, through: :route
  has_one :excuse, dependent: :destroy
  has_one :appointment

  accepts_nested_attributes_for :excuse, :appointment

  enum status: { created: 0, accomplished: 1, not_accomplished: 2 }

  SALE_AMOUNT_FINES = [
    { break_amount: 100_000, fine_amount: 0.15 },
    { break_amount: 200_000, fine_amount: 0.12 },
    { break_amount: 300_000, fine_amount: 0.10 },
    { break_amount: 400_000, fine_amount: 0.08 },
    { break_amount: 500_000, fine_amount: 0.06 },
    { break_amount: 600_000, fine_amount: 0.05 },
    { break_amount: 700_000, fine_amount: 0.04 },
    { break_amount: 1_200_000, fine_amount: 0.03 },
    { break_amount: 3_000_000, fine_amount: 0.02 },
    { break_amount: 10_000_000, fine_amount: 0.01 }
  ]

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
      left_outer_joins(:excuse).group("visits.id, excuses.valid_argument").having("(COUNT(excuses) = 0) OR (COUNT(excuses) > 0 AND excuses.valid_argument = ?)", false)
    end

    def unquestioned
      left_outer_joins(:satisfaction_questionary).having("COUNT(satisfaction_questionaries.id) < 1").group("visits.id")
    end
  end

  def match_name
    "#{salesman.name.try(:capitalize)} visita a #{customer.name.try(:capitalize)}"
  end

  def check_appointment_accomplishment
    if appointment && appointment.realized_at <= appointment.ends_at
      sales = Visit.joins(:route).where(routes: { id: route.id })
      sales_average = (sales.sum(:sale_amount) / sales.size) || 0.0
      binding.pry
      fine_to_apply = SALE_AMOUNT_FINES.find { |fine| sales_average < fine[:break_amount] } || { fine_amount: 0.009 }
      prev_sale_amount = sale_amount
      update(sale_amount: prev_sale_amount - (prev_sale_amount * fine_to_apply[:fine_amount]), original_sale_amount: prev_sale_amount)
    end
  end

  def fill_route_id(salesman_id)
    salesman = Salesman.find_by(id: salesman_id)
    return if salesman.blank?

    self.route_id ||= salesman.routes.by_month(Date.current.month).first.try(:id) || salesman.routes.create.try(:id)
  end
end
