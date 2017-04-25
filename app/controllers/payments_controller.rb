class PaymentsController < ApplicationController


  def new
    @payment = Payment.new
  end



end
