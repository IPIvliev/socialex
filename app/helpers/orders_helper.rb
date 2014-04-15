# encoding: utf-8

module OrdersHelper

	def change_mystock(deal)
		# Если у покупателя пока нет ни одной акции эмитента акций
		if !current_user.mystocks.where(:host_id => deal.host_id).first
			Mystock.create(:user_id => deal.user_id, :host_id => deal.host_id, :price => deal.price, :amount => deal.amount)
		# Если у пользователя уже есть акции этого эмитента
		else
			stock = current_user.mystocks.where(:host_id => deal.host_id).first

			# Вычисляем среднюю стоимость акции данного эмитента (среди акций, принадлежащих этому пользователю)
			one = stock.price * stock.amount + deal.price * deal.amount
			two = stock.amount + deal.amount


			average_price = one / two

			stock.update_attributes(:amount => stock.amount + deal.amount, :price => average_price)
		end
	end

	def make_deal(old_order, new_order, amount)
		@deal = current_user.deals.build(
			:host_id => new_order.host_id,
			:seconduser_id => old_order.user_id,
			:status => old_order.status,
			:amount => amount,
			:price => new_order.price
			)

		@deal.save

		# Меняем стоимость акций эммитента
		User.find(@deal.host_id).update_attribute(:price, @deal.price)		

		# Вносим изменения в имеющиеся у пользователя акции
		change_mystock(@deal)
	end

	def compare_orders_for_buy(new_order)
		for old_order in Order.where("host_id = ? AND status = ? AND price <= ?", new_order.host_id, 2, new_order.price).order("price ASC")
  			unless new_order.frozen? 
 				# Высисляем и сохраняем остаток акций в орадерах на продажу и покупку
  				sum_amounts_in_orders(old_order, new_order)
			end
		end
	end

	def compare_orders_for_sell(new_order)
		for old_order in Order.where("host_id = ? AND status = ? AND price >= ?", new_order.host_id, 1, new_order.price).order("price ASC")
  			unless new_order.frozen?
 				# Высисляем и сохраняем остаток акций в орадерах на продажу и покупку
  				sum_amounts_in_orders(old_order, new_order)
			end
		end
	end

  	# Высисляем и сохраняем остаток акций в орадерах на продажу и покупку
  	def sum_amounts_in_orders(old_order, new_order)
		if old_order.amount > new_order.amount 
			amount = old_order.amount - new_order.amount

			# Создаём сделку
			make_deal(old_order, new_order, new_order.amount)

			old_order.update_attribute(:amount, amount)
			new_order.update_attribute(:amount, 0)

			new_order.destroy

		elsif old_order.amount == new_order.amount 

			# Создаём сделку
			make_deal(old_order, new_order, old_order.amount)

			old_order.update_attribute(:amount, 0)
			new_order.update_attribute(:amount, 0)

			old_order.destroy
			new_order.destroy

		elsif old_order.amount < new_order.amount
			amount = new_order.amount - old_order.amount

			# Создаём сделку
			make_deal(old_order, new_order, old_order.amount)

			old_order.update_attribute(:amount, 0)
			new_order.update_attribute(:amount, amount)

			old_order.destroy

		end	
	end
end
