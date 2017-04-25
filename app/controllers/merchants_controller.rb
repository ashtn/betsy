class MerchantsController < ApplicationController
skip_before_action :require_login, only: [:index, :new, :create, :merchant_items]
  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      flash[:success] = "Successfuly created new Merchant"
      redirect_to merchants_path
    else
      flash.now[:error] = "Merchant could not be created"
      @merchant.errors.messages
      render 'new'
    end
  end

  def show
    @merchant = Merchant.find_by_id(params[:id])
    if !@merchant
      render_404 #find me in ApplicationController
    end
  end

  def merchant_items
    @items = Item.where(merchant_id: params[:id])
    render "/items/index"
  end

  def order_by_status
    @merchant = Merchant.find_by_id(params[:id])
    # @merchant.orders_by_status.where(status: params[:status])
    render '_order_by_status'
    #raise
  end

  private

  def merchant_params
    params.require(:merchant).permit(:username, :email)#, :uid, :provider)
  end

  # def find_merchant
  #   @merchant = Merchant.find_by_id(params[:id])
  # end
end
