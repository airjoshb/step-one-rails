class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    unless @customer.save
      render :new
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:email, :name)
    end
end
