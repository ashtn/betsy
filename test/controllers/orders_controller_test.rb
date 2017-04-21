require "test_helper"

describe OrdersController do

  it "should create an order given valid data" do
    order_data = {
      order: {
      session_id: 1,
      status: "paid",
      total: 25.89}
    }
    post orders_path, params: order_data

    must_respond_with :redirect
  end

  it "renders bad_request for bad data" do
      order = Order.first
      order_data = {
        order: {
          status: "you"
        }
      }

      patch order_path(order), params: order_data
      must_respond_with :not_found

      # Verify the DB was not modified
      Order.find(order.id).status.must_equal order.status
    end

end
