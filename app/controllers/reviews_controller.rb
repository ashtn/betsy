class ReviewsController < ApplicationController
  skip_before_action :require_login

  def new
    @review = Review.new
    @review.item_id = Item.find_by_id(params[:id])
  end

  def create
    @review = Review.new review_params
    @review.item_id = Item.find_by_id(params[:id])
    if @review.save
      # flash is working - ks
      flash[:success] = "Review added successfully"
      redirect_to item_path(params[:id])
    else
      raise
      flash.now[:error] = "Please select a rating."
      render :new
    end
  end

  private
  def review_params
    params.permit(:rating, :description, :item_id)
  end
end
