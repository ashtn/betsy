require 'test_helper'

describe Item do
  let(:item) { Item.new }


  it "Cannot create a item without a name" do
    item.valid?.must_equal false
    #negative test

    item.errors.messages.must_include :name
    #negative test
  end


  it "Can create a item with a name" do
    item.name = "Taquitos"
    # item.price = "123466"
    # # item.merchant_id = 11
    # item.save
    #
    item.valid? #won't run validations until save or valid? is run
    item.errors.messages[:name].must_equal []
  end


  it "You can create a item" do
    item.merchant_id = merchants(:kari).id
    item.name = "Peaches"
    item.price = 5
    item.inventory = 7
    item.photo = "url"
    item.valid?.must_equal true
  end

  it "You cannot not create a item with no price" do
    item.valid?.must_equal false
    #negative test

    item.errors.messages.must_include :price
    #negative test
  end



  it "You cannot not create a item with non integer inventory" do
    item = Item.new
    item.name = "Cheese"
    item.price = 5
    item.inventory = 3.5
    item.merchant_id = merchants(:kari).id

    item.valid?.must_equal false
    #negative test

    item.errors.messages.must_include :inventory
    #negative test
  end

  it "You cannot not create a item with negative inventory" do
    item = Item.new
    item.name = "Cheese"
    item.price = 5
    item.inventory = -1
    item.merchant_id = merchants(:kari).id
    item.valid?.must_equal false
    #negative test

    item.errors.messages.must_include :inventory
    #negative test
  end

  it "You cannot not create a item with negative price" do
    item = Item.new
    item.name = "Cheese"
    item.price = -5
    item.inventory = 1
    item.merchant_id = merchants(:kari).id
    item.valid?.must_equal false
    #negative test

    item.errors.messages.must_include :price
    #negative test
  end

  it "name must be unique" do
    item1 = Item.new
    item1.merchant_id = merchants(:kari).id
    item1.name = "Jello"
    item1.price = 5
    item1.inventory = 3
    item1.photo = "URL"
    item1.save
    item2 = Item.new
    item2.merchant_id = merchants(:kari).id
    item2.name = "Jello"
    item2.price = 5
    item2.inventory = 3
    item2.photo = "URL"
    item2.valid?.must_equal false
    item2.errors.messages[:name].must_equal ["has already been taken"]
  end

end
