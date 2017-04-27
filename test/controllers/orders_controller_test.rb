require "test_helper"

describe OrdersController do

  describe "index" do
    it "should get index" do
      get orders_path
      must_respond_with :redirect
    end
  end

  describe "show" do
    it "can see show" do
      get order_path(orders(:one).id)
      must_respond_with :redirect
    end
  end

  describe "create" do
    it "should create an order given valid data" do
      Order.destroy_all
      order_data = {
        order: {
          session_id: merchants(:kari).id,
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

          must_respond_with :redirect

          Order.all.must_equal []
      end
  end

  # describe "edit" do
  #   it "should get edit" do
  #     get edit_order_path
  #     must_respond_with :success
  #   end
  # end

  describe "update" do
    it "should update an order given valid data" do
      order_data = {
        order: {
          session_id: 1,
          status: "pending",
          total: 25.89}
        }

        put order_path(:id), params: order_data

        must_respond_with :redirect

        Order.find_by_session_id(1).status.must_equal "pending"
    end

      it "shouldn't update an order given invalid data" do
        order_data = {
          order: {
            session_id: 1,
            status: "you",
            total: 25.89}
          }

          put order_path(:id), params: order_data

          must_respond_with :redirect

          Order.find_by_session_id(1).status.must_equal "pending"
      end
  end

  describe "destroy" do

    it "should delete an order and redirect to order list" do
        delete order_path(orders(:one).id)
        must_redirect_to orders_path

        Order.all.must_equal []
      end
  end

  describe "new" do
    it "should show the new order form" do
      get new_order_path
      must_respond_with :redirect
    end
  end


end
