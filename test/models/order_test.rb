require "test_helper"

describe Order do

  describe 'validations' do
    let(:order) { Order.new }

    it "Orders require a session_id, status, and total" do

      order.valid?.must_equal false

      # produces hash of all error messages
      order.errors.messages.must_include :total
    end

    it "If a negative total is given, the order is invalid" do
      order.total = -1.45

      order.valid?.must_equal false
      order.errors.messages[:total].must_equal ["must be greater than -1"]
    end

    it "You can't create an order without a unique session_id" do
        order.session_id = 1
        order.status = "complete"
        order.total = 1.23

        order.valid?.must_equal false
        order.errors.messages[:session_id].must_equal ["has already been taken"]
    end

    it "You can't create an order with an integer total" do
        order.session_id = 1
        order.status = "complete"
        order.total = 5

        order.valid?.must_equal false
        order.errors.messages[:total].must_equal []
    end
  end

  describe 'find_total' do
    it "generates the correct total for two order items" do
      purchased_order_items = []
      purchased_order_items << order_items(:one)
      purchased_order_items << order_items(:two)

      Order.find_total(purchased_order_items).must_equal 17.5
    end

    it "generates the correct total for one order item" do
      purchased_order_items = []
      purchased_order_items << order_items(:two)

      Order.find_total(purchased_order_items).must_equal 1.5
    end

    it "generates the correct total for zero order items" do
      purchased_order_items = []

      Order.find_total(purchased_order_items).must_equal 0
    end

    describe 'change_status_to_paid' do
      it "changes the status of an order to paid" do


        Order.change_status_to_paid(orders(:one).id).must_equal true

        Order.find_by_id(orders(:one).id).status.must_equal "paid"
      end
    end

    describe 'inventory_adjust' do
      it "adjusts inventory based on item quantity bought" do

        Order.inventory_adjust(orders(:one).id)

        Item.find_by_id(items(:chips).id).inventory.must_equal 16 # this locates the items in our fixtures and checks their inventory
        Item.find_by_id(items(:item_two).id).inventory.must_equal 0

      end
    end
  end
end
