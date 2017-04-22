class ReviewsController < ApplicationController

  def index; end

  def new
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new
  end

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new(review_params)
    if @review.save
      flash[:success] = "Review added successfully"
      redirect_to item_path(@item)
    else
      flash.now[:error] = "Error has occured"
      render :new
    end
  end

  private
  def review_params
    params.requiree(:review).permit(:rating, :review)
  end
end
