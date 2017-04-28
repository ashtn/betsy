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

    it "Rating cannot be less than 1" do
      bad_review = Review.new(rating: 0)
      bad_review.save
      bad_review.valid?.must_equal false

    end
    it "Rating cannot be greater than 5" do
      another_bad_review = Review.new(rating: 0)
      another_bad_review.save
      another_bad_review.valid?.must_equal false
    end
    it "If rating is given, the review is valid" do
      review.rating = 4
      review.errors.messages[:rating].must_equal []
    end
    it "Review will be created if rating is present and an integer" do
      item = Item.new
      item.name = "Coconut oil"
      item.price = 4.30
      item.photo = "pic"
      item.merchant_id = merchants(:kari).id
      item.inventory = 5
      item.save
      review = Review.new
      review.rating = 4
      review.description = "Great product"
      review.item_id = item.id
      review.save

      review.valid?.must_equal true
    end
  end
end
