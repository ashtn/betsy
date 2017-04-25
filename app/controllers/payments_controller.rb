class PaymentsController < ApplicationController

  def confirmation
    @order = Order.find_by_id(params[:id])
    @order_items = OrderItem.where(:id => @order.id)
  end

  def new
    @payment = Payment.new
  end
end