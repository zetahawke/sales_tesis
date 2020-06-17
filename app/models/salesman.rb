class Salesman < ApplicationRecord
  has_many :routes
  has_many :visits, through: :routes
  has_many :customers, through: :visits
end
