class Order < ApplicationRecord
  has_many :order_items

  validates :status, presence: true, inclusion: { in: %w(pending paid processing),
    message: "%{value} is not a valid status" }
  validates :session_id, presence: true, uniqueness: true
  validates :total, presence: true, numericality: { only_float: true, greater_than: 0 }
end
