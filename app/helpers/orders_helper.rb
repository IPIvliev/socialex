# encoding: utf-8

module OrdersHelper

	def change_mystock(deal)
		# Если у покупателя пока нет ни одной акции эмитента акций
		if !current_user.mystocks.where(:host_id == deal.host_id).first
			Mystock.create(:user_id => deal.user_id, :host_id => deal.host_id, :price => deal.price, :amount => deal.amount)
		# Если у пользователя уже есть акции этого эмитента
		else
			stock = current_user.mystocks.where(:host_id == deal.host_id).first
			stock.update_attributes(:amount => stock.amount + deal.amount, :price => deal.price)
		end
	end

	def make_deal(second_user, host_id, status, amount, price)
		@deal = current_user.deals.build(
			:host_id => host_id,
			:seconduser_id => second_user,
			:status => status,
			:amount => amount,
			:price => price
			)

		@deal.save

		# Вносим изменения в имеющиеся у пользователя акции
		change_mystock(@deal)
	end

	def compare_orders(new_order, status)
		for old_order in Order.where("host_id = ? AND status = ? AND price >= ?", new_order.host_id, status, new_order.price)
  			unless new_order.frozen?

			if old_order.amount > new_order.amount 
				amount = old_order.amount - new_order.amount

				# Создаём сделку
				make_deal(old_order.user.id, new_order.host_id, status, new_order.amount, new_order.price)

				old_order.update_attribute(:amount, amount)
				new_order.update_attribute(:amount, 0)

				new_order.destroy

			elsif old_order.amount == new_order.amount 

				# Создаём сделку
				make_deal(old_order.user.id, new_order.host_id, status, new_order.amount, new_order.price)

				old_order.update_attribute(:amount, 0)
				new_order.update_attribute(:amount, 0)

				old_order.destroy
				new_order.destroy

			elsif old_order.amount < new_order.amount
				amount = new_order.amount - old_order.amount

				# Создаём сделку
				make_deal(old_order.user.id, new_order.host_id, status, amount, new_order.price)

				old_order.update_attribute(:amount, 0)
				new_order.update_attribute(:amount, amount)

				old_order.destroy
			end							
		end
		end
	end

	# Вычисляем динамику цен
  	def compare(user)
	  	compare = Order.where(:host_id => user.id).order("price ASC").first.price.round(2) / Order.where(:host_id => user.id).order("price ASC").second.price.round(2)

	  	if compare <= 1
	  		return "<span class='red'>#{compare.round(2)}</span>".html_safe
	  	else 
	  		return "<span class='green'>#{compare.round(2)}<span>".html_safe
	  	end
  	
  	end

end
