class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
    redirect_to customers_path(current_customer) unless current_customer == @customer
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

end
