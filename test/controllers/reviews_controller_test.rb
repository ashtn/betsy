require "test_helper"

describe ReviewsController do
  describe "new" do
    it "should show the new review form" do
      get new_item_review_path(items(:item_one).id)
      must_respond_with :success
    end
  end

  describe "create" do
    it "should effect the model when creating a review with a rating" do
      Review.destroy_all
      review_data = {
        review: {
          rating: 5,
          review: "yay",
          item_id: items(:item_two).id
        }
      }
      post item_path(items(:item_two).id), params: review_data
      Review.all.length.must_equal 1
      end
      it "should not effect the model when creating a review without a rating" do
        Review.destroy_all
        review_data = {
          review: {
            rating: 0,
            review: "yay",
            item_id: items(:item_two).id
          }
        }
        post item_path(items(:item_two)), params: review_data
        Review.all.length.must_equal 0
        end
        it "should redirect to item show page after creating a review" do
          Review.destroy_all
          review_data = {
            review: {
              rating: 5,
              review: "yay",
              item_id: items(:item_two).id
            }
          }
          post item_path(items(:item_two)), params: review_data
          must_redirect_to item_path(items(:item_two))
        end

      end
    end
