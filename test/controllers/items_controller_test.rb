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
      login_merchant(merchants(:dan))
    end

    it "get edit form should show edit page" do
      get edit_item_path(items(:item_one).id)
      must_respond_with :success
    end

    it "should get new form" do
      get new_item_path
      must_respond_with :success
    end



    it "should redirect to list after creating item" do
      Item.destroy_all
      item_data = {
        item: {
          merchant_id: merchants(:kari).id,
          name: "paid",
          description: "something",
          price: 25.89,
          inventory: 12,
          photo: "url"}
        }
        post items_path, params: item_data

        must_respond_with :redirect

        Item.all.length.must_equal 1
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
      Item.destroy_all
      item_data = {
        item: {
          merchant_id: merchants(:kari).id,
          name: "paid",
          description: "something",
          price: 25.89,
          inventory: 12,
          photo: "url"}
        }
        post items_path, params: item_data

        must_respond_with :redirect

        Item.all.length.must_equal 1

    end

  it "should delete an item and redirect to items list" do

    proc {
      delete item_path(items(:item_one).id)
    }.must_change 'Item.count', -1
    must_redirect_to items_path
  end


  it "should retire an item" do
    patch retire_path(items(:item_one).id)
    items(:item_one).inventory must_equal 1
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
    Item.destroy_all
    proc {  item_data_1 = {
        item: {
          merchant_id: merchants(:kari).id,
          name: "paid",
          description: "something",
          price: 25.89,
          inventory: 12,
          photo: "url"}
        }
        post items_path, params: item_data_1

        must_respond_with :redirect
        item_data_2 = {
          item: {
            merchant_id: merchants(:kari).id,
            name: "paid",
            description: "something",
            price: 25.89,
            inventory: 12,
            photo: "url"}
          }
          post items_path, params: item_data_2
          must_respond_with :redirect
        }.must_change 'OrderItem.count', 0

    end



    it "does not create additional order item if additional of same added" do
      OrderItem.destroy_all
      patch add_to_cart_path(items(:item_two)), {}, {'HTTP_REFERER' => 'http://foo.com'}
      proc {
        patch add_to_cart_path(items(:item_two)), {}, {'HTTP_REFERER' => 'http://foo.com'}
      }.must_change 'OrderItem.count', 0
    end

    it "updates cart quantity" do
      order_item = {
        oi: {
          item_id: (items(:item_one)),
          order_id: (orders(:one)),
          merchant_id: merchants(:kari).id,
          quantity: 1,
          status: "pending",
          total: 25.89
          }
        }
        patch orders_path, params: order_item
        must_redirect_to items_path
        #what else can we test here?
    end

    it "does not create order item if inventory is zero" do

      proc {
        patch add_to_cart_path(items(:no_stock)), {}, {'HTTP_REFERER' => 'http://foo.com'}
      }.must_change 'OrderItem.count', 0

      must_redirect_to :back
    end

  end

end
