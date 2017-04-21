require "test_helper"

describe Order do
  let(:order) { Order.new }

  it "Orders require a session_id, status, and total" do

    order.valid?.must_equal false

    # produces hash of all error messages
    order.errors.messages.must_include :total
  end

  it "If a total is given the order is valid" do
    order.total = 1
    order.valid?
    order.errors.messages[:total].must_equal []
  end


end
