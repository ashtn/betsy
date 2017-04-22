require "test_helper"

describe Review do
  describe "Review Relationships" do
    it "A review has an item" do
      r = reviews(:one)
      r.must_respond_to :item
      r.item.must_be_kind_of Item
    end
  end

  describe "Review Valdations" do
    let(:review) { reviews(:three) }
    it "Review cannot be created without a rating" do
      new_review = Review.new
      new_review.valid?.must_equal false
    end
    it "If not rating then review isn't valid" do
      review.rating = nil
      review.valid?.must_equal false

      review.errors.messages.must_include :rating
    end
    it "Rating must be an integer" do

    end
    it "Rating cannot be less than 1" do

    end
    it "Rating cannot be greater than 5" do

    end
    it "If rating is given, the review is valid" do
      review.rating = 4
      review.errors.messages[:rating].must_equal []
    end
    it "Review will be created if rating is present and an integer" do
      review.rating = 4
      review.review = "Great product"
      item = Item.new name: "Coconut oil", price: 4.30
      review.item = item
      review.valid?.must_equal true
    end
  end

  describe "Review Custom Methods" do
    # No custom methods needed for this yet
  end
end
