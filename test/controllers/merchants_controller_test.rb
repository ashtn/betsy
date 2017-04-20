require "test_helper"

describe MerchantsController do
  it "should get new" do
    get merchants_new_url
    value(response).must_be :success?
  end

  it "should get create" do
    get merchants_create_url
    value(response).must_be :success?
  end

  it "should get index" do
    get merchants_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get merchants_show_url
    value(response).must_be :success?
  end

end
