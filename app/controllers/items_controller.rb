class ItemsController < ApplicationController

  skip_before_action :require_login, only: [:index, :show, :add_to_cart, :show_cart, :root, :update_cart, :remove_from_cart]

  # Price must be a number
  # Price must be greater than 0
  before_action :find_categories, only: [:show, :edit]

  def roots
    @featured_items = Item.all.sample(3)
  end

  def index
    if params[:category_id]
      # we are in the nested route
      @items = Item.includes(:categories).where(categories: { id: params[:category_id]})
    else
      # we are in our 'regular' route
      @items = Item.all
    end

  end

  def show
    @item = Item.find_by_id(params[:id])
    if !@item
      render_404
    end
  end

  def new
    @item = Item.new

  end

  def create
    @item = Item.new item_params
    @item.merchant_id = find_merchant.id
    @item.category_ids = params[:item][:category_ids]
    @item.save
    unless @item.merchant_id == nil
      redirect_to items_path, flash: {success: "Item added successfully"}
    else
      flash.now[:error] = "Error has occured"
      render "new"
    end
  end

  def edit
    @item=Item.find_by(id: params[:id])
    if @item.nil?
      head :not_found
    else
      params[:category] = @item.category
    end
  end

  def update
    @item = Item.find_by(id: params[:id])

    @item.name = item_params[:name]
    @item.category_ids = params[:item][:category_ids]
    # raise
    if @item.update(item_params)

      redirect_to item_path(@item.id)
    else
      render "edit"
    end
  end

  def destroy
    Item.destroy(params[:id])
    redirect_to items_path
  end

  def add_to_cart
    # if OrderItem.find(params[:id])
    if OrderItem.create(order_id: Order.last.id, merchant_id: Item.find(params[:id]).merchant_id, item_id: params[:id], quantity: 1 )
      flash[:notice] = "Added to Cart!"
      redirect_to :back
    end
  end

  def remove_from_cart
    # OrderItem.destroy(params[:id])
    order_item = OrderItem.find(params[:id])
    order_item.destroy
    flash[:notice] = "Item Deleted"
    redirect_to cart_path
  end

  def show_cart
      @order = Order.where(session_id: session[:id])
      @order_items = OrderItem.where(order_id: @order.last.id)
  end

  def update_cart
     order_item = OrderItem.find(params[:id])
     if order_item.item.inventory >= params[:order_item][:quantity].to_i
       order_item.quantity = params[:order_item][:quantity].to_i
       if order_item.save
         flash[:success] = "Quantity Updated"
       end
       redirect_to cart_path
     else
       flash[:notice] = "Stock too Low!"
       redirect_to cart_path
     end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :inventory, :merchant_id, :category_ids, :photo)
  end

  def find_item
    @item = Item.find_by_id(params[:id])
  end

  # #added by AE
  # def has_cart
  #   if OrderItem.where(order_id: Order.where(session_id: session[:user_id]))
  #     if Order.Where(status: "pending")
  #     end
  #   end
  # end

  def find_user
    if session[:merchant_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end

  def find_categories
    @categories = Category.all
    @categories_names = []
    @categories.each do |category|
      @categories_names << category.name
    end
    # raise
    return @categories_names
  end
  def order_params
    params.require(:order).permit(:session_id, :status, :total)
  end
end
