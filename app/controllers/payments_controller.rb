class PaymentsController < ApplicationController

  def create
    @payment = Payment.create payment_params

    if @payment.id != nil
      flash[:success] = "Payment successful!"
      redirect_to confirmation_path # TODO: make this path
    else
      flash.now[:error] = "Error has occured!"
      render "new"
    end
  end


  def new
    @payment = Payment.new
  end

  private

  def payment_params
    params.require(:payment).permit(:name_on_card, :email, :phone_num, :ship_address, :bill_address, :card_number, :expiration_date, :CCV )
  end

end
