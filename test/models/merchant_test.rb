require "test_helper"

describe Merchant do



  describe "Merchant Validations" do


    it "Can create a Merchant" do
  #create a user
  merchant = Merchant.new(username: "NewMerchant", uid: "999", provider: "github", email: "test@email.org")
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(merchant))
  #try to log in
  proc {
    #get the callback path for github
    #will call the 'create action' in 'SessionsController'
    get auth_github_callback_path
    #check for redirection
    must_redirect_to root_path
    #check that session was set
    session[:user_id].must_equal User.find_by(name: "NewMerchant").id
    #check that new user was created
  }.must_change 'Merchant.count', 1
  must_redirect_to root_path
  flash[:success].must_equal "Logged in successfully!"
end
  #
  #   describe "Username and email address presence" do
  #
  #     it " Does not create Merchant when no name or email is present " do
  #       merchant = Merchant.new
  #       merchant.valid?.must_equal false
  #     end
  #
  #     it " Does not create Merchant when name and no email is present " do
  #       merchant = Merchant.new ({username: "Username"})
  #       merchant.valid?.must_equal false
  #     end
  #
  #     it " Does not create Merchant when email and no name is present " do
  #       merchant = Merchant.new ({email: "Email"})
  #       merchant.valid?.must_equal false
  #     end
  #
  #     it " Creates Merchant " do
  #       merchant = Merchant.new ({username: "Username", email: "Email"})
  #       merchant.valid?.must_equal true
  #       merchant.save
  #       merchant.id?.must_equal true
  #       merchant.username.must_equal "Username"
  #       merchant.email.must_equal "Email"
  #     end
  #   end
  #
  #   describe "Username and email address are unique" do
  #
  #     it " Does not create Merchant when given an identical username" do
  #       merchant = Merchant.new ({username: "TestUsername", email: "email"})
  #       merchant.valid?.must_equal false
  #     end
  #
  #     it " Does not create Merchant when given an identical email address" do
  #       merchant = Merchant.new ({username: "Username", email: "TestEmail"})
  #       merchant.valid?.must_equal false
  #     end
  #
  #     it " Creates Merchant When name and email are present" do
  #       merchant = Merchant.new ({username: "TestUsernameThree", email: "TestEmailThree"})
  #       merchant.valid?.must_equal true
  #       merchant.save
  #       merchant.id?.must_equal true
  #       merchant.username.must_equal "TestUsernameThree"
  #       merchant.email.must_equal "TestEmailThree"
  #     end
  #   end
  end

  # =====
  describe "Merchant Relationships" do
    let(:m) { merchants(:kari) }

    it " has items" do
      m.items.length.must_equal 2
      m.items.first.name.must_equal items(:item_one).name
      m.items.first.price.must_equal items(:item_one).price
    end

    it " has order items" do
      m.order_items.count.must_be :>, 1
      m.order_items.must_include order_items(:one)
      m.order_items.must_include order_items(:two)
    end

    it "does not have order items, that aren't theirs" do
      m.order_items.count.must_equal 3
      m.order_items.wont_include order_items(:three)
    end
  end

  describe " Merchant Custom methods" do
    let(:m) { merchants(:kari) }

    it " Can find all merchant orders" do
      m.merchant_orders.count.must_equal 2
      m.merchant_orders.must_include orders(:one)
    end

    it " Can find merchant Items by order" do
      m.items_by_order(orders(:one)).must_include order_items(:one)
    end

    describe "Revenue methods" do
      it "can find total merchant revenue" do
        m.revenue.must_be :>, 0
      end

      it " can find revenue by status" do
        m.revenue_by_status(orders(:one).status).must_be :>, 0
      end

      it " items by can find revenue by order" do
        m.revenue_by_order(orders(:one)).must_be :>, 0
      end

    end
    describe "By Status Methods" do
      it "includes list of order statuss" do
        m.order_status.count.must_equal 4
        m.order_status.must_include "paid"
        m.order_status.must_include "pending"
        m.order_status.must_include "complete"
        m.order_status.must_include "canceled"
      end

      it "Can find list of orders by status " do
        m.orders_by_status(orders(:one).status).must_include orders(:one)
      end

      it " can find a list of order items by status" do
        # TODO is this method used at all?
      end

      it " Can find total number of orders by status" do
        m.total_orders_by_status(orders(:one).status).must_equal 1
      end
    end
  end
end
