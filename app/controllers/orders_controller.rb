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

				# Проверяем наличие ордеров на продажу, соответствующих заявке
				if Order.where("host_id = ? AND status = ? AND price <= ?", @order.host_id, 2, @order.price)
					compare_orders(@order, 2)
				end

				
			    flash[:success] = "Вы успешно разместили заявку на покупку #{@order.amount}."
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
		# Есть ли у продавца акции данного пользователя
		if current_user.mystocks.where("host_id = ?", @order.host_id).first
			# Проверяем, есть ли акции у продавца
			if current_user.mystocks.where("host_id = ?", @order.host_id).first.amount >= @order.amount
				if @order.save

					#  Вычитаем стоимость акций из бюджета пользователя
					current_user.mystocks.where("host_id = ?", @order.host_id).first.update_attribute(:amount,
					 current_user.mystocks.where("host_id = ?", @order.host_id).first.amount - @order.amount)

					# Проверяем наличие ордеров на покупку, соответствующих заявке
					if Order.where("host_id = ? AND status = ? AND price <= ?", @order.host_id, 1, @order.price)
						compare_orders(@order, 1)
					end					
					
					
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
		# Если пользователь и продавец - одно лицо
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