class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    # @order = Order.new(order_params)
    # @order.customer_id = current_customer.id

    # if params[:address_option] == 0
    #   @order.name = current_customer.name
    #   @order.post_cord = current_customer.post_cord
    #   @order.address = current_customer.address
    # elsif params[:address_option] == 1
    #   @address = Address.find(params[:address_book])
    #   @order.name = @address.name
    #   @order.post_cord = @address.post_cord
    #   @order.address = @address.address
    # elsif params[:address_option] == 2
    #   @order.name = params[:name]
    #   @order.post_cord = params[:post_cord]
    #   @order.address = params[:address]
    # end

    # @order.total_payment = params[:total_price].to_i + @order.postage

    # @cart_items = current_customer.cart_items


  end

  def create

  end

  def complete

  end

  def index

  end

  def show

  end

  private

  def order_params
    params.require(:order).permit(:payment_method)
  end

end
