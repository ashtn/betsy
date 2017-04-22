require "test_helper"

describe ReviewsController do
  describe "new" do
    it "should show the new review form" do
      skip
      r = reviews(:two)
      i = items(:item_one)

      get new_item_review_path, :item_id=> 1
      must_respond_with :success
    end
    it "should redirect to item show page after adding a review" do

    end

  end

  describe "create" do
    it "should effect the model when creating a review with a rating" do
      skip
      # proc{
      #   post reviews_path, params: { review:
      #     { rating: 4,
      #       review: "yay",
      #       item_id: 2
      #   } }
      # }.must_change 'Review.count', 1
      Review.destroy_all
      review_data = {
        review: {
          item_id: 1,
          rating: 4,
          review: "yay"
        }
      }
      post reviews_path, params: review_data

      Review.all.length.must_equal 1
    end
    it "should not effect the model when creating a review without a rating" do

    end

  end
end
