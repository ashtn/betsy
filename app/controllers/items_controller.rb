class ItemsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :add_to_cart, :show_cart]

  # Price must be a number
  # Price must be greater than 0
  before_action :find_categories, only: [:show, :edit]

  def index
    if params[:category_id]
      # we are in the nested route
      # retrieve items based on the genre
      # @items = Item.includes(:category).where(category: { id: params[:category_id]})
      @items = Item.includes(:categories).where(categories: { id: params[:category_id]})
    else
      # we are in our 'regular' route
      @items = Item.all
    end

  end

  def show
    @item = Item.find_by_id(params[:id])
    @reviews = Review.where(item_id: @item.id)

    if !@item
      # render_404
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
    # if @item.nil?
    #   head :not_found
    # else
    #   params[:category] = @item.category
    # end
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
    item = Item.find(params[:id])
    all = Order.all
    # session[:current_order_id] = 1
    # raise
    if Order.all.length == 0
      session[:current_user_id] = 1
      # order = Order.new
      # order.session_id = 1
      # order.save
    end

    if session[:current_user_id] == nil
      session[:current_user_id] = (Order.all.last.session_id + 1)
    end

    if Order.all.length != 0 && session[:current_user_id] == Order.all.last.session_id
      order_item = OrderItem.create(order_id: Order.last.id, merchant_id: Item.find(params[:id]).merchant_id, item_id: params[:id], quantity: 1 )
      #set order session id
    else
      order = Order.new

      if Order.all.length < 1
        order.session_id = 1
        order.status = "pending"
        order.total = 0.0
        order.save
      else
        order.session_id = (Order.all.last.session_id + 1)
        order.status = "pending"
        order.total = 0.0
        order.save

      end
      order.save
      order_item = OrderItem.create(order_id: Order.last.id, merchant_id: Item.find(params[:id]).merchant_id, item_id: params[:id], quantity: 1 )

      # OrderItem.where(order_id: (all.last.id)).each do |oi|
      # # OrderItem.where(order_id: session[:current_order_id]).each do |oi|
      #   order.total += oi.item.price
      #   order.save
      # end
      # raise
    end
    # raise
    flash[:notice] = "Added to Cart!"
    redirect_to :back
  end

  def remove_from_cart
    OrderItem.destroy(params[:id])
  end



  def show_cart
    if session[:current_user_id] == Order.last.session_id
    @order_items = OrderItem.where(order_id: Order.last.id)
  else
    @order_items = nil
  end
    # raise
  end






  # raise
  # order = nil
  # # if there is a :current_order_id aka this user has items in cart
  # if session[:current_order_id]
  #   # calling the existing session 'order'
  #   order = Order.find(session[:current_order_id])
  #   # add item to order
  #
  #   # OrderItem.create(item: find_item, order: order)
  #   OrderItem.create(order_id: order.id, merchant_id: Item.find(params[:id]).merchant_id, item_id: params[:id], quantity: 2 )
  #
  #   order.save!
  #   # raise
  # else
  #   # creates a new :current_order_id
  #   all = Order.all
  #   order = Order.new
  #   if Order.all.length == 0
  #     order.session_id = 1
  #   else
  #     order.session_id = (all.last.id + 1)
  #   end
  #   order.status = "pending"
  #   order.total = 1
  #   order.save!
  #   session[:current_order_id] = order.id
  #   # and add item to order
  #
  # end
  # # creating order row in the order items join table and also adding the item id to the join table
  # order.order_items.create(item: find_item)

  #order.total = params[:order][total => Order.find_total(order.order_items)]
  #order.save!
  # TODO: should actually redirect to cart



  # where(session: (session[:id]).order(vote_count: :desc).limit(10)
  # order.where(session: session[:user_id]).where(work_id: params[:id]) == []    en




  # Order.new(item.id)
  # item.order.status = "in cart"


  # where(session: (session[:id]).order(vote_count: :desc).limit(10)
  # order.where(session: session[:user_id]).where(work_id: params[:id]) == []    end
  # end

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
