require "test_helper"

describe SessionsController do
  describe "auth_callback" do
    it "Can log in an existing merchant" do
      proc {
        login_merchant(merchants(:kari))
        must_redirect_to root_path
        session[:merchant_id].must_equal merchants(:kari).id
      }.must_change 'Merchant.count', 0
    end

    it "Can creat a new merchant" do
      jamie = Merchant.new(username: "Jamie", uid: "999", provider: "github", email: "Jamie@adadevelopersacademy.org")
      proc {
        login_merchant(jamie)
        must_redirect_to root_path
        session[:merchant_id].must_equal Merchant.find_by(username: "Jamie").id
        flash[:success].must_equal "Logged in successfully!"
      }.must_change 'Merchant.count', 1
    end

    it "Cannot log in without a valid Auth_Hash" do
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({})
      proc {
        get auth_github_callback_path
        must_redirect_to root_path
        session[:merchant_id].must_be_nil
        flash[:error].must_equal "Could not log in."
      }.must_change 'Merchant.count', 0
    end
  end
  describe "Logging out" do
    it "Can log out a logged in user" do
      login_merchant(merchants(:kari))
      delete logout_path
      session[:merchant_id].must_be_nil
      flash[:success].must_equal "You have successfully loged out"
      must_redirect_to root_path
    end
  end
end
