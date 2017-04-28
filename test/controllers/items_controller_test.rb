require "test_helper"

describe ItemsController do
  describe "Merchant is not logged in" do
  it "should get index" do
    get items_path
    must_respond_with :success
  end

  it "should get show" do
    get item_path(items(:item_one).id)
    must_respond_with :success
  end


  it "should show a 404 when item not found" do
    get item_path(1)
    must_respond_with :missing
  end

  end
  describe "Merchant is logged in" do
    before do
      login_user(merchants(:dan))
    end

  it "get edit form should show edit page" do
    get edit_item_path(items(:item_one).id)
    must_respond_with :success
  end

  it "should get new form" do
    get new_item_path
    must_respond_with :success
  end

  it "should get create" do
    post new_item_path
    must_respond_with :success
    must_redirect_to items_path
  end

  it "should redirect to list after creating item" do
    post new_item_path(items(:item_two).id)
    must_redirect_to items_path
  end

  it "should get edit" do

    get edit_item_path(items(:item_one).id)
    must_respond_with :success
  end

  it "should get update" do
    get edit_item_path(items(:item_one).id)
    must_respond_with :success
  end

  it "should affect the model when creating an item" do
    proc {
      post new_item_path(items(:item_one))
    }.must_change 'Item.count', 1

  end

  it "should delete an item and redirect to items list" do

    proc {
      delete item_path(items(:item_one).id)
    }.must_change 'Item.count', -1
    must_redirect_to items_path
  end
end

  describe "Cart Features" do

    it "should affect the model when adding an item to cart" do

      proc {
        patch add_to_cart_path(items(:item_one)), {}, {'HTTP_REFERER' => 'http://foo.com'}
      }.must_change 'OrderItem.count', 1
    end

    it "should affect the model when removing an item from cart" do

      proc {
        delete remove_from_cart_path(order_items(:one).id), {}, {'HTTP_REFERER' => 'http://foo.com'}
      }.must_change 'OrderItem.count', -1

    end

    it "does not create addition order_item when adding second of same item to cart" do
      proc {
        patch add_to_cart_path(items(:item_one)), {}, {'HTTP_REFERER' => 'http://foo.com'}
        patch add_to_cart_path(items(:item_one)), {}, {'HTTP_REFERER' => 'http://foo.com'}
      }.must_change 'OrderItem.count', 1
    end

    it "update quantity when submit qauantity change in  cart view" do

    end
  end

end
