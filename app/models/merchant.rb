class Merchant < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :items
  has_many :orders
  has_many :ordered_items, through: :items, source: :order_items

  def self.create_from_github(auth_hash)
    merchant = Merchant.new
    merchant.uid = auth_hash["uid"]
    merchant.provider = auth_hash["provider"]
    merchant.username = auth_hash["info"]["nickname"]
    merchant.email = auth_hash["info"]["email"]

    merchant.save ? nickname : nil

  end


  def items_by_order(order_id)
    items = merchant_orders.where(order_id: order_id)
    return items
  end

  def order_items(merchant_id)
    order_items = OrderItem.where(merchant_id: merchant_id)
    return order_items #order item objects
  end

  def merchant_orders(merchant_id)
    orders = order_items(merchant_id).map { |order_item| order_item.order }
    return orders
  end


  def revenue_by_id(merchant_id)
    #based on item's current price, with assumption price doesn't change
    total_revenue = 0
    order_items(merchant_id).each do |order_item| total_revenue += order_item.item.price
    end
    return total_revenue
  end


  def order_by_status(status)
    TODO # returns an integer
  end

  def revenue_by_status(status)
    TODO #returns a float
  end



end


#sample data

#o = Order.create(session_id: 2, status: "paid", total: 100.00)


# m = Merchant.create(username: "Ada", email: "email@test.com", uid: 1, provider: "github")


# oi = item_id: nil, order_id: 1, quantity: nil,
# merchant_id: Merchant.where(item_id: )>



# item = Item.create(merchant_id: 7, name: "Green", description: "Beans Description", price: 10.00, inventory: 30, photo: nil)


# oi = OrderItem.create(item_id: 9, order_id: 4, quantity: 5, merchant_id: 8)
# oi = OrderItem.create(item_id: 7, order_id: 4, quantity: 4, merchant_id: 8)
# oi = OrderItem.create(item_id: 8, order_id: 4, quantity: 3, merchant_id: 8)
# oi = OrderItem.create(item_id: 5, order_id: 4, quantity: 4, merchant_id: 7)
# oi = OrderItem.create(item_id: 4, order_id: 4, quantity: 3, merchant_id: 10)
