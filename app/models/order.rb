class Order < ApplicationRecord
  has_many :order_items

    validates :status, presence: true, inclusion: { in: %w(pending paid complete cancelled), message: "%{value} is not a valid status" }
    validates :session_id, presence: true
    # validates :total, presence: true, numericality: { only_float: true, greater_than: -1 }

    def total_cost

      total = 0.0

      self.order_items.each do | order_item |
        item = Item.find_by_id(order_item.item_id)
        total += (item.price * order_item.quantity)
      end
      return total.round(2)
    end

    def self.change_status_to_paid(order_id)
      order = Order.find_by_id(order_id)
      order.status = "paid"
      order.save

    end

    def inventory_adjust

      self.order_items.each do | order_item |
        item = Item.find_by_id(order_item.item_id)
        if order_item.quantity <= item.inventory
          item.inventory -= order_item.quantity # reduce that items inventory by the quantity bought
          puts item.merchant_id
          item.save
        end
      end
    end
end
