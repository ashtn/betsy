class SessionsController < ApplicationController
  skip_before_action :require_login#, only: [:create]


  def login_form; end

  def create
    # will be used for omniAuth and OAuth business
  end

  def login
    merchant = Merchant.find_by_username(params[:username])
    if merchant
      session[:merchant_id] = merchant.id
      flash[:success] = "Welcome back #{ merchant.username }"
      redirect_to items_path
    else
      flash.now[:error] = "Merchant not found"
      render :login_form
    end
  end


  def logout
    session.delete(:merchant_id)
    flash[:success] = "You have successfully loged out"
    redirect_to items_path
  end

end
