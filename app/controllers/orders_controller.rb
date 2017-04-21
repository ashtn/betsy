class OrdersController < ApplicationController

  # do we need a show method ?

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

  def update

    @order = Order.find_by_session_id(order_params[:session_id])

    @order.status = order_params[:status]

    if @order.save
      redirect_to order_path
    else
      render "edit"
    end
  end

  def destroy
    Order.destroy(params[:session_id])

    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:session_id, :status, :total)
  end
end
