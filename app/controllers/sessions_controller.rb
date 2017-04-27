class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:create]
  #skip_before_action :require_login, only: [:login_form, :login]

  # def login_form; end

  def create
    auth_hash = request.env['omniauth.auth']

    merchant = Merchant.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])

    if merchant.nil?
      merchant = Merchant.create_from_github(auth_hash)
      if merchant.nil?
        flash[:error] = "Could not log in."
      else
        session[:merchant_id] = merchant.id
        flash[:success] = "Logged in successfully!"
      end
    else
      session[:merchant_id] = merchant.id
      flash[:success] = "Logged in successfully!"
    end
    redirect_to root_path
  end

  # def login
  #   merchant = Merchant.find_by_username(params[:username])
  #   if merchant
  #     session[:merchant_id] = merchant.id
  #     flash[:success] = "Welcome back #{ merchant.username }"
  #     redirect_to items_path
  #   else
  #     flash.now[:error] = "Merchant not found"
  #     render :login_form
  #   end
  # end


  def logout
    session[:merchant_id] = nil
    flash[:success] = "You have successfully loged out"
    redirect_to root_path
  end

end
