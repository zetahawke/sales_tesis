class Excuse < ApplicationRecord
  belongs_to :visit
  has_one :salesman, through: :visit

  after_create :set_visit_status

  def set_visit_status
    visit.update(status: 2)
  end
end
