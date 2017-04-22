class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :add_header_text


  def add_header_text
     @categories = Category.all
     @merchants = Merchant.all
  end

end
