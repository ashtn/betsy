class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :add_header_text
  helper_method :current_merchant


  def add_header_text
     @categories = Category.all
     @merchants = Merchant.all
  end

  def require_login
    if !session[:merchant_id]
      flash[:warning] = "You must be logged in to view this page"
      redirect_to items_path
    end
  end

  def current_merchant
    @logged_in_merchant ||= Merchant.find(session[:merchant_id]) if session[:merchant_id]
  end

  def render_404
    render file: "#{ Rails.root }/public/404.html", status: 404
  end
end
