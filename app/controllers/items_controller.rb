class ItemsController < ApplicationController

  # before_action :find_item, only: [:show, :edit, :update]
  # skip_before_action :require_login, only: [:index]

  def new
    @item = Item.new
  end

  def create
    @item = Item.create item_params
    unless @item.id == nil
      flash[:success] = "Item added successfully"
      redirect_to items_path

    else
      flash.now[:error] = "Error has occured"
      render "new"
    end
  end

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
    if !@item
      # render_404
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
    params.require(:item).permit(:name, :description, :price, :inventory)
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


  # def index
  #   @items = Item.all
  # end
  #
  # def new
  #   @item = Item.new
  # end
  #
  # def create
  # end
  #
  # def edit
  # end
  #
  # def update
  # end
  #
  # def show
  # end

end
