require "test_helper"

describe OrdersController do
  describe "create" do
    it "should create an order given valid data" do
      Order.destroy_all
      order_data = {
        order: {
          session_id: 1,
          status: "paid",
          total: 25.89}
        }
        post orders_path, params: order_data

        must_respond_with :redirect

        Order.all.length.must_equal 1
    end

      it "shouldn't create an order given invalid data" do
        Order.destroy_all
        order_data = {
          order: {
            session_id: 1,
            status: "you",
            total: 25.89}
          }
          post orders_path, params: order_data

          must_respond_with :success

          Order.all.must_equal []
      end
  end

  describe "update" do
    it "should update an order given valid data" do
      order_data = {
        order: {
          session_id: 1,
          status: "paid",
          total: 25.89}
        }

        put order_path(:id), params: order_data

        must_respond_with :redirect

        Order.find_by_session_id(1).status.must_equal "paid"
    end

      it "shouldn't update an order given invalid data" do
        order_data = {
          order: {
            session_id: 1,
            status: "you",
            total: 25.89}
          }
          put order_path(:id), params: order_data

          must_respond_with :success

          Order.find_by_session_id(1).status.must_equal "pending"
      end
  end
end
