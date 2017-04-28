class ItemsController < ApplicationController

  skip_before_action :require_login, only: [:index, :show, :add_to_cart, :show_cart, :root, :update_cart, :remove_from_cart]


  # Price must be a number
  # Price must be greater than 0
  before_action :find_categories, only: [:show, :edit]

  def root
    @featured_items = Item.all.sample(3)
  end

  def index
    if params[:category_id]
      # we are in the nested route
      @items = Item.includes(:categories).where(categories: { id: params[:category_id]})
      hide_retired
      if current_merchant
        @items = @items.where(merchant_id: current_merchant.id)
      end
      # raise
    else
      # we are in our 'regular' route
      @items = Item.all
      hide_retired
      # raise
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
    @item.merchant_id = current_merchant.id
    @item.category_ids = params[:item][:category_ids]
    if @item.save
      # @item.merchant_id == nil
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
      params[:category] = @item.categories
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

  def retire
    @item = Item.find_by(id: params[:id])
    @item.inventory = nil
    if @item.save
      flash[:success] = "Item Succesfully Retired"
      redirect_to items_path
    end
  end

  def destroy
    if Item.destroy(params[:id])
      flash[:success] = "Item Succesfully Deleted"
      redirect_to items_path
    else
      flash[:success] = "Unable to Delete "
      redirect_to items_path
    end
  end

  def add_to_cart
    # if OrderItem.find(params[:id])
    # item = Item.find_by(id: params[:id]

    if existing_order_item && sufficient_inventory
      increase_quantity
      flash[:notice] = "Added to cart!"
      redirect_to :back
    elsif existing_order_item && !sufficient_inventory
      flash[:notice] = "Not enough in stock!"
      redirect_to :back
    elsif !existing_order_item && !sufficient_inventory
      flash[:notice] = "Not enough in stock!"
      redirect_to :back
    else

    #  raise
      if OrderItem.create(order_id: Order.last.id, merchant_id: Item.find(params[:id]).merchant_id, item_id: params[:id], quantity: 1 )
        flash[:notice] = "Added to Cart!"
        redirect_to :back
      else
        flash[:notice] = "something went wrong"
        redirect_to items_path
      end
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
         redirect_to cart_path
       end
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

  def sufficient_inventory
    if @oi.length > 0
      item = Item.find(@oi.last.item_id)
      if item.inventory > 0
        # raise
        if @oi.last.quantity < item.inventory
          return true
        else
          return false
        end
      end
    else
      return true
    end
  end

  def existing_order_item
     order = Order.find_by(session_id: session[:id])
     @oi = OrderItem.where(item_id: params[:id], order_id: order.id)
     if @oi.length > 0
       return true
     else
       return false
     end
  end

  def increase_quantity
    @oi.last.quantity += 1
    @oi.last.save
  end

  def order_params
    params.require(:order).permit(:session_id, :status, :total)
  end

   def hide_retired
    @items =  @items.where.not(inventory: nil)
    return @items
   end
end
