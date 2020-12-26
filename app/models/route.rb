class Route < ApplicationRecord
  belongs_to :salesman
  has_many :visits, dependent: :destroy
  
  validate :monthly_uniqueness

  class << self
    def data_by(type, date)
      date = date.to_date
      case type
      when 'monthly' then by_month(date.try(:month))
      when 'yearly' then by_year(date.try(:year))
      else
        all
      end
    end

    def by_month(month = Date.current.month)
      where('EXTRACT(MONTH FROM routes.created_at) = ?', month)
    end

    def by_year(year = Date.current.year)
      where('EXTRACT(YEAR FROM routes.created_at) = ?', year)
    end
  end

  private

  def monthly_uniqueness
    routes = Route.where("EXTRACT(MONTH from created_at) = ? and EXTRACT(YEAR from created_at) = ? and salesman_id = ?", Date.current.month, Date.current.year, salesman_id)
    errors.add(:created_at, 'No puede existir más de una ruta para el mismo vendedor dentro del mes actual') unless routes.blank?
  end
end
