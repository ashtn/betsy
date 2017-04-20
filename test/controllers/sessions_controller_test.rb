require "test_helper"

describe SessionsController do
  it "should get create" do
    get sessions_create_url
    value(response).must_be :success?
  end

  it "should get logout" do
    get sessions_logout_url
    value(response).must_be :success?
  end

end
