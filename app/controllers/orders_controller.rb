class OrdersController < ApplicationController

  skip_before_action :require_login, only: [:pay, :paid, :create]

  def index
    @orders = Order.all
  end

  def show
    current_merchant
    @result_order = Order.find(params[:id])
    @payment = Payment.where(order_id: params[:id]).first
  end

  def create
    @order = Order.create order_params
    puts "error: #{@order.errors.messages}"
    if @order.id != nil
      flash[:success] = "Order added successfully!"
      redirect_to orders_path
    else
      flash.now[:error] = "Error has occured!"
      render "edit"
    end
  end

  # def edit
  #   @order = Order.find(params[:id])
  # end

  def update
    @order = Order.find_by_id(params[:id])
    @order.status = order_params[:status]
    if @order.save
      redirect_to order_path
    else
      flash.now[:error] = "Error has occured!"
      render "edit"
    end
  end

  def destroy
    Order.destroy(params[:id])
    redirect_to orders_path
  end

  def new
    @order = Order.new
  end

  def pay
    @payment = Payment.new
    @order = Order.find(params[:id])
    render "pay_form"
  end

  def paid
     # The default column for payment is id, but id in this methods context is
     # an order_id, so we need to reassign it, so it stores the order_id in the correct column name.
    actual_params = payment_params
    actual_params[:order_id] = params[:id]
    @payment = Payment.create actual_params

    if @payment.id != nil
      flash[:success] = "Payment successful!"
      order_id = params[:id] # to clarify that this is an order ID, not payment ID
      @order = Order.find(params[:id])

      Order.change_status_to_paid(params[:id])
      @order.inventory_adjust
      session[:id] = nil
      redirect_to confirmation_path(order_id)
    else
      flash.now[:error] = "Error has occured!"
      @order = Order.find(params[:id])
      render "pay_form"
    end
  end

  private

  def order_params
    params.require(:order).permit(:session_id, :status, :total)
  end

  def payment_params
    params.require(:payment).permit(:name_on_card, :email, :phone_num, :ship_address, :bill_address, :card_number, :expiration_date, :CCV, :order_id )
  end

end
