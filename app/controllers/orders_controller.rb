class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @result_order = Order.find(params[:id])
  end


  def create
    @order = Order.create order_params

    if @order.id != nil
      flash[:success] = "Order added successfully!"
      redirect_to orders_path
    else
      flash.now[:error] = "Error has occured!"
      render "new"
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update

    @order = Order.find_by_id(params[:id])

    if @order.save
      redirect_to order_path
    else
      flash.now[:error] = "Error has occured!"
      render "edit"
    end
  end

  def destroy
    Order.destroy(params[:session_id])

    redirect_to orders_path
  end

  def new
    @order = Order.new
  end

  private

  def order_params
    params.require(:order).permit(:session_id, :status, :total)
  end
end
