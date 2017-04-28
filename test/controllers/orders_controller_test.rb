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

          must_respond_with :success

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
    before do
      login_merchant(merchants(:kari))
    end
    it "should update an order given valid data" do
      order_data = {
        order: {
          session_id: 1,
          status: "complete",
          total: 25.89
        }
      }


      put order_path(orders(:one).id), params: order_data

      must_respond_with :redirect

        Order.find_by_session_id(1).status.must_equal "complete"
    end

      it "shouldn't update an order given invalid data" do
        order_data = {
          order: {
            session_id: 1,
            status: "you",
            total: 25.89
          }
        }

          put order_path(orders(:one).id), params: order_data

          must_respond_with :success
          Order.find_by_session_id(1).status.must_equal "pending"
      end
  end

  # describe "destroy" do
  #
  #   it "should delete an order and redirect to order list" do
  #       delete order_path(orders(:one).id)
  #       must_redirect_to orders_path
  #
  #       Order.all.must_equal []
  #     end
  # end

  describe "new" do
    it "should show the new order form" do
      get new_order_path
      must_respond_with :redirect
    end
  end

  describe "pay" do
    it "should show the pay form" do
      get pay_path(orders(:one).id)
      must_respond_with :success
    end
  end

  describe "paid" do
    it "should change the status of an order given a valid payment" do
      order_to_test = orders(:one)
        pymt_data = {
          payment: {
            name_on_card: "Joe Blow",
            email: "joeblow@hotmail.com",
            phone_num: "5555555555",
            ship_address: "123 Amazing Street",
            bill_address: "123 Amazing Street",
            card_number: 1111111111111111,
            expiration_date: 2222,
            CCV: 333
          }
        }

        post paid_path(order_to_test.id), params: pymt_data
        must_respond_with :redirect

        Order.find_by_id(order_to_test.id).status.must_equal "paid"
        Payment.where(order_id: order_to_test.id).length.must_equal 1
    end

      it "shouldn't create order if payment is invalid" do
        order_to_test = orders(:one)
          pymt_data = {
            payment: {
              name_on_card: "Joe Blow",
              email: "joeblow@hotmail.com",
              phone_num: "5555555555",
              ship_address: "123 Amazing Street",
              bill_address: "123 Amazing Street",
              card_number: 1111111111111111,
              expiration_date: 2222,
              CCV: 3
            }
          }

          post paid_path(order_to_test.id), params: pymt_data
          must_respond_with :success

          Order.find_by_id(order_to_test.id).status.must_equal "pending"
          Payment.where(order_id: order_to_test.id).length.must_equal 0
      end
  end

end
