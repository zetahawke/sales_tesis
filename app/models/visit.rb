class Visit < ApplicationRecord
  belongs_to :customer
  belongs_to :route
  has_one :salesman, through: :route
end
