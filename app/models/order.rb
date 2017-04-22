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

    def self.change_status
      # if CC numbers are valid, order.id.status == "paid"
      # will need a payment form that is accessed through a "pay" button on cart
      # the pay button should also check inventory to make sure that we have enough in stock
    end

    def self.inventory
      if order.status == "paid"
        order_item(item.id).inventory -= 1 # reduce that items inventory by one
        # clear items from cart
      end
    end
end
