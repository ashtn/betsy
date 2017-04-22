class CategoriesController < ApplicationController
  def create
  end

  def new
  end

  def index
    @categories = Category.all
  end
end
