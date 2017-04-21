class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(params[:id])
    if @merchant.save
      flash[:success] = "Successfuly created new Merchant"
      redirect_to merchant_path(@merchant.id)
    else
      flash.now[:error] = "Merchant could not be created"
      @merchant.errors.messages
      render 'new'
    end
  end

  def show
  end

  private

  def merchant_params
    params.require(:merchant).permit(:username, :email)
  end

  def find_merchant
    # could be good to put 404 error here
    @merchant = Merchant.find_by_id(params[:id])
  end
end
