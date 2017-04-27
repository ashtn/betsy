require "test_helper"

describe MerchantsController do
  describe "index" do
    it 'should get index' do
      Merchant.count.must_be :>, 0
      get merchants_path
      must_respond_with :success
    end
  end

  describe "new" do
    it 'should get new page' do
      get new_merchant_path
      must_respond_with :success
    end
  end

  describe "create" do
    # Logging into git hub creates a merchant tough... is there need to test it here too?

    it "Model data increases after creating merchant" do
      skip
      proc {
        post merchants_path, params:
        { merchant:
          { username: "Test",
            email: "test@test.com",
            uid: "12345",
            provider: "github"
            }
          }
        }.must_change 'Merchant.count', 1
      end

    it 'should redirect after creating merchant ' do
      skip
      post merchants_path, params: { merchant:
        { username: "Test", email: "test@test.com"
        }}
      must_respond_with :redirect
    end
  end

  describe "show" do
    before do
      login_merchant(merchants(:dan))
    end
    it "should get show" do
      get merchant_path(merchants(:kari).id)
      must_respond_with :success
    end

    it 'should show a 404 when merchant not found' do
      get merchant_path(Merchant.last.id + 1)
      must_respond_with :not_found
    end
  end

  describe "merchant_items" do
  end

  describe "order_by_status" do
  end
  
  describe "ship" do
  end
end
