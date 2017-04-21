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

  def edit; end

  def update
    @item.title = item_params[:title]
    @item.author = Author.find(item_params[:author_id])
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

  private

  def item_params
    params.require(:item).permit(:title, :author_id, :description, :isbn)
  end

  def find_item
    @item = Item.find_by_id(params[:id])
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
