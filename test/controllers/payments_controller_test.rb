require "test_helper"

describe PaymentsController do
  it "should get new" do
    get pay_path
    value(response).must_be :success?
  end

end
