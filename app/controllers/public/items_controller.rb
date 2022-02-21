class Public::ItemsController < ApplicationController
  def index
    if params[:sort].present?
      @genre = Genre.find_by(name: "#{params[:sort]}")
      @items = Item.where(genre_id: @genre.id).page(params[:page]).per(8)
      @items_count = Item.where(genre_id: @genre.id).count
      @index_title = "#{params[:sort]}"
    else
      @items = Item.page(params[:page]).per(8)
      @items_count =Item.all.count
      @index_title = "商品一覧"
    end
     @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

end
