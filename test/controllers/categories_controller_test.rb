require "test_helper"

describe CategoriesController do

  it " should get new" do
    get new_category_path
    must_respond_with :success
  end

  it " data should increase after creating category" do
    proc {
      post categories_path, params: {category:
        { name: "Test"}}
      }.must_change 'Category.count', 1
    end

  it " should redirect after create" do
    post categories_path params: {
      category: {name: "Test"}
    }
    must_respond_with :redirect
    must_redirect_to categories_path
  end

  it " should get index" do
    get categories_path
    must_respond_with :success
  end

  it " should get show" do
    get category_path(Category.first)
    must_respond_with :success
  end
end
