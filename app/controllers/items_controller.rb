class ItemsController < ApplicationController
skip_before_action :require_login#, only: [:index, :show]

# Price must be a number
# Price must be greater than 0


  # before_action :find_item, only: [:show, :edit]

  def index
    if params[:category_id]
      # we are in the nested route
      # retrieve items based on the genre
      @items = Item.includes(:category).where(category: { id: params[:category_id]})
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

    # Order.new(item.id)
    # item.order.status = "in cart"


    # where(session: (session[:id]).order(vote_count: :desc).limit(10)
    # order.where(session: session[:user_id]).where(work_id: params[:id]) == []    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :inventory, :merchant_id)
  end

  def find_item
    @item = Item.find_by_id(params[:id])
  end




  private
    def find_user
      if session[:user_id]
        @login_user = User.find_by(id: session[:user_id])
      end
    end

end
