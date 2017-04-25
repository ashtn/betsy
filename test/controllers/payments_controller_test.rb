require "test_helper"

describe PaymentsController do
  it "should get new" do
    get payments_new_url
    value(response).must_be :success?
  end

end
