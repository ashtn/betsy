class PaymentsController < ApplicationController
  skip_before_action :require_login, only: [:confirmation, :new]

  def confirmation
    @order = Order.find_by_id(params[:id])
    @order_items = OrderItem.where(:order_id => @order.id)
    item_ids = @order_items.map { |i| i.item_id }.uniq
    @items = Item.find(item_ids)
  end

end
