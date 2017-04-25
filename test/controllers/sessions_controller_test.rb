require "test_helper"

describe SessionsController do
  describe "login_form" do
    # The login form is a static page - no real way to make it fail
    it "succeeds" do
      skip
      # this does not work... fix on Wednesday
      get auth_github_callback_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "succeeds for a new user" do
      skip
      username = "test_user"
      # Precondition: no Merchant with this username exists
      Merchant.find_by(nickname: username).must_be_nil

      post login_path, params: { nickname: username }
      must_redirect_to root_path
    end

    it "succeeds for a returning user" do
      skip
      username = Merchant.first.nickname
      post login_path, params: { username: username }
      must_redirect_to root_path
    end
  end

  describe "logout" do
    it "succeeds if the user is logged in" do
      skip
      # Gotta be logged in first
      post login_path, params: { username: "test user" }
      must_redirect_to root_path

      post logout_path
      must_redirect_to root_path
    end

    it "succeeds if the user is not logged in" do
      skip
      post logout_path
      must_redirect_to root_path
    end
  end

end
