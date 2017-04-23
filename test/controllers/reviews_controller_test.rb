require "test_helper"

describe ReviewsController do
  describe "new" do
    it "should show the new review form" do
      get new_item_review_path(items(:chips).id)
      must_respond_with :success
    end
  end

  describe "create" do
    it "should effect the model when creating a review with a rating" do
      proc{
        post item_path(items(:chips).id), params: { review:
          { rating: 3,
          description: "yay" }
        }
      }.must_change 'Review.count', 1

    end
    it "should not effect the model when creating a review without a rating" do
      proc{
        post item_path(items(:chips).id), params: { review:
          { rating: "",
          description: "yay" }
        }
      }.must_change 'Review.count', 0
    end
    it "should redirect to item show page after creating a review" do
      post item_path(items(:chips).id), params: {
        review: {rating: 4, description: "yay"}
      }
      must_respond_with :redirect
      must_redirect_to item_path(items(:chips).id)
    end

  end
end
