class Order < ApplicationRecord
  has_many :order_items

  validates :status, presence: true, inclusion: { in: %w(pending paid complete cancelled),
    message: "%{value} is not a valid status" }
    validates :session_id, presence: true, uniqueness: true
    validates :total, presence: true, numericality: { only_float: true, greater_than: 0 }

    def self.find_total(order_items)
      total = 0.0

      order_items.each do | order_item |
        item = Item.find_by_id(order_item.item_id)
        total += (item.price * order_item.quantity)
      end
      return total
    end

    def self.change_status_to_paid(order_id) # "submit order" button on cart need to be linked to this method
      order = Order.find_by_id(order_id)
      order.status = "paid"
      order.save
    end

    def self.inventory_adjust(order_id)

      order_items = OrderItem.where(order_id: order_id)

      order_items.each do | order_item |
        item = Item.find_by_id(order_item.item_id)
        if order_item.quantity <= item.inventory
          item.inventory -= order_item.quantity # reduce that items inventory by the quantity bought
          item.save
        else
          # TODO: handle cases where we don't have enough inventory
        end
      end
    end
end
