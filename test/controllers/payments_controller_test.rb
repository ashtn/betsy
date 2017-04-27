require "test_helper"

describe PaymentsController do


  describe "confirmation" do
    it "generates class variables" do
      get confirmation_path(payments(:one).id)
      must_respond_with :success
    end
  end

end
