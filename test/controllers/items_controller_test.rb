require "test_helper"

describe ItemsController do
  it "should get index" do
    get items_path
    must_respond_with :success
  end

  it "should get show" do
    get item_path(items(:chips).id)
    must_respond_with :success
  end

  # it "should show a 404 when item not found" do
  #   get item_path(1)
  #   must_respond_with :missing
  # end

  it "get edit form should show edit page" do
    get edit_item_path(items(:chips).id)
    must_respond_with :success
  end

  it "should get new form" do
    get new_item_path
    must_respond_with :success
  end

  it "should get create" do
    get new_item_path
    must_respond_with :success
  end

  it "should redirect to list after adding item" do
    post items_path params: {item:
      { name: "Salsa",
        merchant_id: merchants(:one).id,
        description: "Yummy",
        price: 5,
        inventory: 22
      } }
    must_redirect_to items_path
  end

  it "should get edit" do
    get edit_item_path(items(:chips).id)
    must_respond_with :success
  end

  it "should get update" do
    get edit_item_path(items(:chips).id)
    must_respond_with :success
  end

  it "should affect the model when creating an item" do
    proc {
      post items_path params: {item:
        { name: "Salsa",
          merchant_id: merchants(:one).id,
          description: "Yums",
          price: 5,
          inventory: 22
        } }
    }.must_change 'Item.count', 1

  end

  it "should delete an iten and redirect to items list" do
  delete item_path(items(:chips).id)
  must_redirect_to items_path
end

end
