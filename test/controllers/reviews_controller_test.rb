require "test_helper"

describe ReviewsController do
  describe "new" do
    it "should show the new review form" do
      get new_item_review_path(items(:item_one).id)
      must_respond_with :success
    end
  end

  describe "create" do
    before do

    end
    it "should effect the model when creating a review with a rating" do
      item = items(:item_two)
      Review.destroy_all
      review_data = {
        review: {
          item_id: item.id,
          rating: 3,
          description: "yay"
        }
      }
      post item_reviews_path, params: review_data
      must_respond_with :redirect
      Review.all.length.must_equal 1
    end
    it "should not effect the model when creating a review without a rating" do
      proc{
        post item_path(items(:item_one).id), params: { review:
          { rating: "",
          description: "yay" }
        }
      }.must_change 'Review.count', 0
    end
    it "should redirect to item show page after creating a review" do
      skip
      post item_path(items(:item_one).id), params: {
        review: {rating: 4, description: "yay"}
      }
      must_respond_with :redirect
      must_redirect_to item_path(items(:item_one).id)
    end

  end
end
