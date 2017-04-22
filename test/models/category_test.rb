require "test_helper"

describe Category do

  describe " validations" do

      it " Does not create a new category without name" do
        category = Category.new
        category.valid?.must_equal false
      end

      it " Successfully create a new category" do
        category = Category.new(name: "Test")
        category.valid?.must_equal true
        category.save
        category.id?.must_equal true
        category.name.must_equal "Test"
      end

      it "Does not create duplicate categories" do
        category = Category.new(name: categories(:one).name)
        category.valid?.must_equal false
      end

  end
end
