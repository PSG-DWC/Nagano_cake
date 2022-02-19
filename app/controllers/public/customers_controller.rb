class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
    redirect_to customers_path(current_customer) unless current_customer == @customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "You have updated  successfully."
      redirect_to customers_path(current_customer)
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kane, :post_code, :address, :phone_number, :email)
  end

end
