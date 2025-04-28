class CustomersController < ApplicationController
  invisible_captcha only: [:create], honeypot: :subtitle
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if !@customer.save
      render :new
    else 
      render :create
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:email, :name, :promotion_consent)
    end
end
