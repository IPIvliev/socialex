# encoding: utf-8

class OrdersController < ApplicationController
include OrdersHelper

def new
	@order = Order.new
end

def create
	@order = current_user.orders.build(params[:order])
	if @order.save
		trade(current_user.id, @order.host_id)
	    flash[:success] = "Поздравляем Вас с успешной регистрацией. Теперь Вы можете подать заявку"
	    redirect_to user_path(@order.host_id)
    else
	    flash.now[:error] = 'Регистрация не удалась. Вы не заполнили, либо не правильно заполнили одно из полей.'
	    redirect_to user_path(params[:order][:user_id])
    end
end

end