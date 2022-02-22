class Public::CartItemsController < ApplicationController
  def create



    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item.present?
      @cart_item.amount += params[:cart_item][:amount].to_i
      if @cart_item.save
        flash[:notice] = "#{@cart_item.item.name}の個数を変更しました。"
        redirect_to cart_items_path
      else
        @item = Item.find(@cart_item.item_id)
        @genres = Genre.all
        render template: "public/items/show"
      end
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
      if @cart_item.save
        flash[:notice] = "カートに商品を追加しました。"
        redirect_to cart_items_path
      else
        @item = Item.find(@cart_item.item_id)
        @genres = Genre.all
        render template: "public/items/show"
      end
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
    flash[:notice] = "#{@cart_item.item.name}を削除しました。"
    @cart_item.destroy
    redirect_to request.referer
  end

  def destroy_all
    CartItem.destroy_all
    flash[:notice] = "カートに商品を空にしました。"
    redirect_to request.referer
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "#{@cart_item.item.name}の個数を変更しました。"
      redirect_to request.referer
    else
      render :edit
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end