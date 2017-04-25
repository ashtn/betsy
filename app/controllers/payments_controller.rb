class PaymentsController < ApplicationController
  skip_before_action :require_login, only: [:confirmation, :new]

  def confirmation
    @order = Order.find_by_id(params[:id])
    @order_items = OrderItem.where(:id => @order.id)
    @items = Item.where(:id => @order.id)
  end

  def new
    @payment = Payment.new
  end
end
