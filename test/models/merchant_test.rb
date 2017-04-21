require "test_helper"

describe Merchant do

  describe "Merchant Validations" do

    describe "Username and email address presence" do

      it " Does not create Merchant when no name or email is present " do
        merchant = Merchant.new
        merchant.valid?.must_equal false
      end

      it " Does not create Merchant when name and no email is present " do
        merchant = Merchant.new ({username: "Username"})
        merchant.valid?.must_equal false
      end

      it " Does not create Merchant when email and no name is present " do
        merchant = Merchant.new ({email: "Email"})
        merchant.valid?.must_equal false
      end

      it " Creates Merchant when name and email are present" do
        merchant = Merchant.new ({username: "Username", email: "Email"})
        merchant.valid?.must_equal true
        merchant.save
        merchant.id?.must_equal true
        merchant.username.must_equal "Username"
        merchant.email.must_equal "Email"
      end
    end

    describe "Username and email address are unique" do

      it " Does not create Merchant when given an identical username" do
        merchant = Merchant.new ({username: "TestUsername", email: "email"})
        merchant.valid?.must_equal false
      end

      it " Does not create Merchant when given an identical email address" do
        merchant = Merchant.new ({username: "Username", email: "TestEmail"})
        merchant.valid?.must_equal false
      end

      it " Creates Merchant When name and email are present" do
        merchant = Merchant.new ({username: "TestUsernameThree", email: "TestEmailThree"})
        merchant.valid?.must_equal true
        merchant.save
        merchant.id?.must_equal true
        merchant.username.must_equal "TestUsernameThree"
        merchant.email.must_equal "TestEmailThree"
        # has id = id
        # has name = name s
        # has email = email
      end
    end
  end

  describe "Merchant Relationships" do
    it " Returns a list of items, given merchant with items" do
      skip
    end

    it " Returns error message, when retriving items, given merchant with no items." do
      skip
    end
  end
end
