class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "New #{@category.name} cateogry has been successfully created"
      redirect_to categories_path
    else
      flash[:error] = "Category could not be created"
      @category.errors.messages
      render 'new'
    end
  end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by_id(params[:id])
    if !@category
      render_404
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
