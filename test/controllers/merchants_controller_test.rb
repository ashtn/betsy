
require "test_helper"

describe MerchantsController do
  describe "index" do
    it 'should get index' do
      Merchant.count.must_be :>, 0
      get merchants_path
      must_respond_with :success
    end
  end

  describe "new" do
    it 'should get new page' do
      get new_merchant_path
      must_respond_with :success
    end
  end

  describe "show" do
    before do
      login_merchant(merchants(:dan))
    end
    it "should get show" do
      get merchant_path(merchants(:kari).id)
      must_respond_with :success
    end

    it 'should show a 404 when merchant not found' do
      get merchant_path(Merchant.last.id + 1)
      must_respond_with :not_found
    end
  end

  describe "merchant_items" do
    before do
      login_merchant(merchants(:dan))
    end
    it "should return an array of items" do
      get merchant_items_path(:dan)
      must_respond_with :success
    end
  end

  describe "order_by_status" do
    before do
      login_merchant(merchants(:dan))
    end
    it "takes you to the order by status page" do
      get order_by_status_path(merchants(:dan).id, orders(:one).status)
      must_respond_with :success
    end
    # How should I be testing render??
  end

  describe "ship" do
    before do
      login_merchant(merchants(:kari))
    end
    it "should ship" do
      #  ship_order PUT    /merchants/:id/ship/:order_item(.:format)  merchants#ship
      put ship_order_path(merchants(:kari).id, order_items(:two).id )
      must_respond_with :success
    end
  end
end
