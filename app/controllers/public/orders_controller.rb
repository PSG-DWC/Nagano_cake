class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:address_option] == "0"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
    elsif params[:order][:address_option] == "1"
      @address = Address.find_by(id: params[:order][:address_book])
      @order.name = @address.name
      @order.post_code = @address.post_code
      @order.address = @address.address
    elsif params[:order][:address_option] == "2"
      @order.name = params[:order][:name]
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
    end

    @order.total_payment = params[:total_price].to_i + @order.postage

    @cart_items = current_customer.cart_items
     @total_price = 0
     @cart_items.each do |cart_item|
      @item = Item.find_by(id: cart_item.item_id)
      @price = (@item.price * 1.1)*(cart_item.amount)
      @total_price += @price
    end


  end

  def create
    # orderの作成
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800

    if @order.save
        cart_items = current_customer.cart_items
        cart_items.each do |cart|
          #order_deteilsの作成
          @order_detail = OrderDetail.new
          @order_detail.item_id = cart.item_id
          @order_detail.order_id = @order.id
          @order_detail.amount = cart.amount
          @order_detail.price = cart.item.price
          @order_detail.save
       end
        # カートの中身を空にする
       cart_items.destroy_all
       redirect_to complete_orders_path
    else
      render :confirm
    end





  end

  def complete
    @order_details = OrderDetail.all
  end

  def index
    @orders = Order.where(customer: current_customer)
  end

  def show

  end

  private

  def order_params
    params.require(:order).permit(:payment_method,:post_code, :address, :name, :total_payment)
  end


end
