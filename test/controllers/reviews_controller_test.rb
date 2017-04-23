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

    end
    it "should not effect the model when creating a review without a rating" do

    end

  end
end
