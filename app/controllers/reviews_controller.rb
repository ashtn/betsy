class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @review.item_id = params[:item_id]
  end

  def create
    @review = Review.new(review_params)
    @item = Item.find(params[:id])
    @review.item_id = @item.id
    if @review.save
      # flash isn't working atm
      flash.now[:success] = "Review added successfully"
      redirect_to item_path(@item)
    else
      flash.now[:error] = "Error has occured"
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :description, :item_id)
  end
end
