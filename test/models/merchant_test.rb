require "test_helper"

describe Merchant do

  it "Can create a new merchant" do
    jamie = Merchant.new(username: "Jamie", uid: "999", provider: "github", email: "Jamie@adadevelopersacademy.org")
    proc {
      login_merchant(jamie)
      must_redirect_to root_path
      session[:merchant_id].must_equal Merchant.find_by(username: "Jamie").id
      flash[:success].must_equal "Logged in successfully!"
    }.must_change 'Merchant.count', 1
  end


  describe "Merchant Relationships" do
    let(:m) { merchants(:kari) }

    it " has items" do
      m.items.length.must_equal 3
      m.items.first.name.must_equal items(:item_one).name
      m.items.first.price.must_equal items(:item_one).price
    end

    it " Has order items" do
      m.order_items.count.must_be :>, 1
      m.order_items.must_include order_items(:one)
      m.order_items.must_include order_items(:two)
    end

    it " Does not have order items, that aren't theirs" do
      m.order_items.count.must_equal 4
      m.order_items.wont_include order_items(:three)
    end
  end

  describe " Merchant Custom methods" do
    let(:m) { merchants(:kari) }

    it " Can find all merchant orders" do
      m.merchant_orders.count.must_equal 3
      m.merchant_orders.must_include orders(:one)
    end

    it " Can find merchant Items by order" do
      m.items_by_order(orders(:one)).must_include order_items(:one)
    end

    describe " Revenue methods" do
      it " Can find total merchant revenue" do
        m.revenue.must_be :>, 0
        m.revenue.must_be_instance_of Float
        m.revenue.must_equal 36
      end

      it " Can find revenue by status" do
        m.revenue_by_status(orders(:four).status).must_be :>, 0
      end

      it " Retuns 0 if there is no revenue for a given status" do
        m.revenue_by_status("complete").must_equal 0
      end

      it " Can find revenue by order" do
        order = orders(:four)
        order_item = order_items(:five)

        m.revenue_by_order(order).must_be :>, 0
        m.revenue_by_order(order).must_equal order_item.item.price * order_item.quantity
      end

      it " Does not calculate revenue from other merchant order_items" do
        order = orders(:four)
        m.revenue_by_order(order).must_be :<, order.total
      end

    end
    describe "By Status Methods" do
      it " Includes list of order statuss" do
        m.order_status.count.must_equal 4
        m.order_status.must_include "paid"
        m.order_status.must_include "pending"
        m.order_status.must_include "complete"
        m.order_status.must_include "canceled"
      end

      it " Can find list of orders by status " do
        m.orders_by_status(orders(:four).status).must_include orders(:four)
        m.orders_by_status(orders(:four).status).count.must_be :>, 1
      end

      it " Can find a list of order items by status" do
        # TODO is this method used at all?
      end

      it " Can find total number of orders by status" do
        m.total_orders_by_status(orders(:one).status).must_equal 1
      end
    end
  end
end
