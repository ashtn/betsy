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

  end

  describe 'total_cost' do
    it "generates the correct total for two order items" do
      order = Order.find(orders(:one).id)

      order.total_cost.must_equal 17.5
    end

    it "generates the correct total for one order item" do
      order = Order.find(orders(:two).id)

      order.total_cost.must_equal 1.5
    end

    it "generates the correct total for zero order items" do
      order = Order.find(orders(:three).id)

      order.total_cost.must_equal 0
    end

    describe 'change_status_to_paid' do
      it "changes the status of an order to paid" do


        Order.change_status_to_paid(orders(:one).id).must_equal true

        Order.find_by_id(orders(:one).id).status.must_equal "paid"
      end
    end

    describe 'inventory_adjust' do
      it "adjusts inventory based on item quantity bought" do

        order = Order.find(orders(:one).id)
        order.inventory_adjust

        Item.find_by_id(items(:item_one).id).inventory.must_equal 16 # this locates the items in our fixtures and checks their inventory
        Item.find_by_id(items(:no_stock).id).inventory.must_equal 0

      end
    end
  end
end
