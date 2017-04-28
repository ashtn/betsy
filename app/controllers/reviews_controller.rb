class ReviewsController < ApplicationController
  skip_before_action :require_login

  def new
    @review = Review.new
    @review.item_id = params[:item_id]
  end

  def create
    @review = Review.new
    @review.item_id = params[:review][:item_id]
    @review.rating = params[:review][:rating]
    @review.description = params[:review][:description]
    @review.save
      if @review.id != nil
        # flash is working - ks
        flash[:success] = "Review added successfully"
        redirect_to item_path(params[:id])
      else
        flash.now[:error] = "Please select a rating."
        render :new
      end
  end

  # private
  # def review_params
  #   params.permit(:rating, :description, :item_id)
  # end
end
