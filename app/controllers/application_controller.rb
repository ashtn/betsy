class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :add_header_text
  helper_method :current_merchant
  before_action :require_login, :require_user



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

  def require_user
    if !session[:merchant_id]
      if !session[:id]
        if Order.all.length == 0
          session[:id] = 1
          @order = Order.new
          @order.save
          @order.session_id = 1
        else
          @order = Order.new
          @order.id = (Order.last.id + 1)
          session[:id] = Order.last.session_id + 1
          @order.status = "pending"
          @order.session_id = session[:id]
          @order.total = 0
          @order.save
          # raise
        end
      end
    end
  end

  def render_404
    render file: "#{ Rails.root }/public/404.html", status: 404
  end

  def current_merchant
    if session[:merchant_id]
      @login_merchant = Merchant.find_by(id: session[:merchant_id])
    end
  end
end
