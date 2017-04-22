require "test_helper"

describe Order do
  let(:order) { Order.new }

  it "Orders require a session_id, status, and total" do

    order.valid?.must_equal false

    # produces hash of all error messages
    order.errors.messages.must_include :total
  end

  it "If a negative total is given, the order is invalid" do
    order.total = -1.45

    order.valid?.must_equal false
    order.errors.messages[:total].must_equal ["must be greater than 0"]
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
