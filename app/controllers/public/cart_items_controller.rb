class Public::CartItemsController < ApplicationController
  def create



    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item.present?
      @cart_item.amount += params[:cart_item][:amount].to_i
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
    end

    if @cart_item.save
      redirect_to cart_items_path
    else
      render :show
    end

  end

  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
    @cart_items.each do |cart_item|
      @item = Item.find_by(id: cart_item.item_id)
      @price = (@item.price * 1.1)*(cart_item.amount)
      @total_price += @price
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to request.referer
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to request.referer
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end