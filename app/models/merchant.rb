class Merchant < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_many :items
  has_many :order_items
  accepts_nested_attributes_for :items


  def self.create_from_github(auth_hash)
    merchant = Merchant.new

    if auth_hash["uid"] == nil || auth_hash["provider"] == nil || auth_hash["info"] == nil
      return nil
    end

    merchant.uid = auth_hash["uid"]
    merchant.provider = auth_hash["provider"]
    merchant.username = auth_hash["info"]["nickname"]
    merchant.email = auth_hash["info"]["email"]

    merchant.save ? merchant : nil

  end


  def merchant_orders
    # TODO Self.orders?
    orders = order_items.map { |order_item| order_item.order }
    return orders.uniq
  end

  def items_by_order(order_id)
    # TODO order_id.order_items?
    items = order_items.where(order_id: order_id)
    return items
  end


  def revenue
    total_revenue = 0
    orders_by_status('paid').each {|order| total_revenue += revenue_by_order(order)}
    orders_by_status('complete').each {|order| total_revenue += revenue_by_order(order)}
    return total_revenue.round(2)
  end

  def revenue_by_status(status)
    # TODO returns float
    total = 0
    orders_by_status(status).map do |order|
      total += revenue_by_order(order)
    end
    return total.round(2)
  end

  def revenue_by_order(order)
    # TODO returns float
    total = 0
    items_by_order(order).map {|order_item| total += subtotal(order_item)}
    return total.round(2)
  end


  def order_status
    status = %w(pending paid complete canceled)
    return status
  end

  def orders_by_status(status)
    #TODO # retuns order objects
    orders = merchant_orders.select do |order|
      order.status == status
    end
    return orders
  end

  # def items_by_status(status)
  #   # TODO returns order_item objects
  #   items = order_items.where(status: status)
  #   return items
  # end

  def total_orders_by_status(status)
    # TODO # returns an integer
    return orders_by_status(status).length
  end


  def subtotal(order_item)
    return order_item.item.price * order_item.quantity
  end

end
