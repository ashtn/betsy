class Order < ApplicationRecord
  has_many :order_items

  validates :status, presence: true, inclusion: { in: %w(pending paid complete cancelled),
    message: "%{value} is not a valid status" }
    validates :session_id, presence: true, uniqueness: true
    validates :total, presence: true, numericality: { only_float: true, greater_than: 0 }

    def self.find_total(order_items)
      total = 0.0

      order_items.each do | item |
        total += item.price
      end
      return total
    end
end
