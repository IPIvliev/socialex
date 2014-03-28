# encoding: utf-8

class OrdersController < ApplicationController
include OrdersHelper

def new
	@order = Order.new
end

def create
	@order = current_user.orders.build(params[:order])

	# Если ордер размещён на покупку
	if @order.status == 1
		# Вычисляем стоимость всех акций в заявке
		price = @order.amount * @order.price

		# Проверям, хватает ли средств у покупателя
		if current_user.pocket >= price

			if @order.save

				#  Вычитаем стоимость акций из бюджета пользователя
				current_user.update_attribute(:pocket, current_user.pocket - price)

				trade_order(current_user.id, @order.host_id)
			    flash[:success] = "Вы успешно разместили заявку на покупку."
			    redirect_to :back
		    else
			    flash.now[:error] = 'Регистрация не удалась. Вы не заполнили, либо не правильно заполнили одно из полей.'
			    redirect_to :back
		    end
		else

			# Если средств не хватает, то сообщаем об этом пользователю
			flash[:danger] = "У Вас недостаточно средств для совершения сделки."
			redirect_to :back
		end

	# Если ордер размещён на продажу
	elsif @order.status == 2
		# Проверяем, есть ли акции у продавца
		if current_user.mystocks.where("host_id = ?", @order.host_id).first
			if current_user.mystocks.where("host_id = ?", @order.host_id).first.amount >= @order.amount
				if @order.save

					#  Вычитаем стоимость акций из бюджета пользователя
					current_user.mystocks.where("host_id = ?", @order.host_id).first.update_attribute(:amount,
					 current_user.mystocks.where("host_id = ?", @order.host_id).first.amount - @order.amount)

					trade_order(current_user.id, @order.host_id)
				    flash[:success] = "Вы успешно разместили заявку на продажу."
				    redirect_to :back
			    else
				    flash.now[:error] = 'Регистрация не удалась. Вы не заполнили, либо не правильно заполнили одно из полей.'
				    redirect_to :back
			    end
			else
				# Если акций в наличии не хватает, то сообщаем об этом пользователю
				flash[:danger] = "У Вас недостаточно акций данного пользователя для совершения сделки."
				redirect_to :back
			end
		elsif current_user.id == @order.host_id && current_user.stock >= @order.amount
			if @order.save

				current_user.update_attribute(:stock, current_user.stock - @order.amount)
				flash[:success] = "Вы успешно разместили ордер на продажу своих акций."
				redirect_to :back				
			else

			end



		else
			flash[:danger] = "У Вас нет акций данного пользователя. Сделка невозможна."
			redirect_to :back
		end
	end
end

end