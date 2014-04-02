# encoding: utf-8

module OrdersHelper

	def make_deal(second_user, host_id, status, amount, price)
		@deal = current_user.deals.build(
			:host_id => host_id,
			:seconduser_id => second_user,
			:status => status,
			:amount => amount,
			:price => price
			)

		@deal.save
	end

	def compare_orders(new_order, status)
		Order.where("host_id = ? AND status = ? AND price <= ?", new_order.host_id, status, new_order.price).each do |old_order|
			if old_order.amount > new_order.amount 
				amount = old_order.amount - new_order.amount

				make_deal(old_order.user.id, new_order.host_id, 1, amount, new_order.price)

				old_order.update_attribute(:amount, amount)
				new_order.update_attribute(:amount, 0)

				new_order.destroy

			elsif old_order.amount == new_order.amount 

				make_deal(old_order.user.id, new_order.host_id, 1, new_order.amount, new_order.price)

				old_order.update_attribute(:amount, 0)
				new_order.update_attribute(:amount, 0)

				old_order.destroy
				new_order.destroy

			else old_order.amount < new_order.amount
				amount = new_order.amount - old_order.amount

				make_deal(old_order.user.id, new_order.host_id, 1, amount, new_order.price)

				old_order.update_attribute(:amount, 0)
				new_order.update_attribute(:amount, amount)

				old_order.destroy
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
