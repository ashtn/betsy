class CategoriesController < ApplicationController



  def create
  end

  def new
  end

  def index
    @categories = Category.all
  end

  def show
    @items = Category.find_by(@item_category)
  end


end
