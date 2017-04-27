require "test_helper"

describe OrderItem do
let(:order_item) { OrderItem.new }

  describe 'validations' do

    it "Order items require a quantity" do

      order_item.valid?.must_equal false

      order_item.errors.messages.must_include :quantity
    end

    it "If a negative quantity is given, the order item is invalid" do
      order_item.quantity = -1

      order_item.valid?.must_equal false
      order_item.errors.messages[:quantity].must_equal ["must be greater than 0"]
    end

  end
end
