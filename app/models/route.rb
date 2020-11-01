class Route < ApplicationRecord
  belongs_to :salesman
  has_many :visits, dependent: :destroy
end
