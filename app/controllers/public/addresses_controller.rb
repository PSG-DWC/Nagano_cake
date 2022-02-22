class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!

  def index
    @address = current_customer.addresses.new
    @addresses = current_customer.addresses.all
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      flash[:notice] = "#{@address.name}さんの配送先を登録しました。"
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses.all
      render 'index'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    flash[:notice] = "#{@address.name}さんの配送先を削除しました。"
    @address.destroy
    redirect_to addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "#{@address.name}さんの配送先を編集しました。"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:name, :post_code, :address).merge(customer_id: current_customer.id)
  end

end
