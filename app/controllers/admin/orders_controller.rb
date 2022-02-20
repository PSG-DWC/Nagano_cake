class Admin::OrdersController < ApplicationController
 
 def index
  @orders = Order.all.order(created_at: :desc).page(params[:page]).per(10)
 end
 
 def show
  
 end

 def update
 end

end
