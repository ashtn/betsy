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

    merchant.save ? username : nil

  end


  def items_by_order(order_id)
    items = merchant_order_items.where(order_id: order_id)
    return items
  end


  def order_items_by_id(merchant_id)
    order_items = OrderItem.where(merchant_id: merchant_id)
    return order_items #order item objects
  end

  def all_order_ids(merchant_id)
    order_ids = order_items_by_id(merchant_id).map {| order_item | order_item.order_id }
    return order_ids
  end


  def all_orders_by_id(merchant_id)
    orders = all_order_ids(merchant_id).map {|id | Order.find id }
    return orders
  end



  def revenue_by_id(merchant_id)
    #based on item's current price, with assumption price doesn't change
    total_revenue = 0
    order_items_by_id(merchant_id).each do |order_item| total_revenue += Item.find_by(id: order_item.item_id).price
    end
    return total_revenue
  end

  def revenue_by_status(status)
    TODO
  end



end


#sample data

#o = Order.create(session_id: 2, status: "paid", total: 45.00)


# m = Merchant.create(username: "Ada", email: "email@test.com", uid: 1, provider: "github")


# oi = item_id: nil, order_id: 1, quantity: nil,
# merchant_id: Merchant.where(item_id: )>
#
#


# item = Item.create(merchant_id: 7, name: "Green", description: "Beans Description", price: 10.00, inventory: 30, photo: nil)


# oi = OrderItem.create(item_id: 1, order_id: 1, quantity: 5, merchant_id: 7)
# oi = OrderItem.create(item_id: 2, order_id: 1, quantity: 4, merchant_id: 7)
# oi = OrderItem.create(item_id: 3, order_id: 1, quantity: 3, merchant_id: 7)
