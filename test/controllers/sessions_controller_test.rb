require "test_helper"

describe SessionsController do
  describe "auth_callback" do
    it "Can log in an existing merchant" do
      proc {
        login_user(merchants(:kari))
        must_redirect_to root_path
        session[:merchant_id].must_equal merchants(:kari).id
      }.must_change 'Merchant.count', 0
    end
    it "Can creat a new merchant" do
      jamie = User.new(name: "Jamie", uid: "999", provider: "github", email: "Jamie@adadevelopersacademy.org")
    end
  end
end
