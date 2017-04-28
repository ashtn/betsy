require "test_helper"

describe CategoriesController do
let(:need_login) { login_merchant(merchants(:kari)) }

  it " should get new" do
    need_login
    get new_category_path
    must_respond_with :success
  end

  it " Data should increase after creating category" do
    need_login
    proc {
      post categories_path, params: {category:
        { name: "Test"}}
      }.must_change 'Category.count', 1
    end

  it " Should redirect after create" do
    need_login
    post categories_path params: {
      category: {name: "Test"}
    }
    must_respond_with :redirect
    must_redirect_to categories_path
  end

  it " Should flash error, render template, and not increase db on failure to create " do

    proc {
      need_login
      post categories_path params: {category: {name: "TestCategory"}}
      flash[:error].must_equal "Category could not be created"
      assert :must_render_template
    }.must_change 'Category.count', 0
  end

  it " Should get index" do
    get categories_path
    must_respond_with :success
  end

  it " Should get a list of items for a secific category" do
    get category_items_path(Category.first.id)
    must_respond_with :success
  end

  it "  Should render 404 if category could not be found" do
      get category_items_path(Category.last.id + 1)
      assert :must_render_template
  end
end
