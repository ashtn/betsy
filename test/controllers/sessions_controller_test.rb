require "test_helper"

describe SessionsController do
  describe "auth_callback" do
    it "Can log in an existing user" do
      proc {
        login_user(merchants(:kari))
        must_redirect_to root_path
        session[:merchant_id].must_equal merchants(:kari).id
      }.must_change 'Merchant.count', 0
    end
  end
end
