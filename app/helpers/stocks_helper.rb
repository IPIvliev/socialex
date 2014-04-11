# encoding: utf-8

module StocksHelper

	def stock_price(id)
		if Deal.where(:host_id => id).last
			price = Deal.where(:host_id => id).last.price.round(2)
			return "#{price} руб."
		else
			return "100 руб."
		end
	end

	# Вычисляем динамику цен
  	def compare(user)
  		# Последняя цена за акцию
  		if !Deal.where(:host_id => user.id).blank? 
  			last_price = Deal.where(:host_id => user.id).last.price
			if !Deal.where(:host_id => user.id).order("created_at DESC").second.nil?
				second_price = Deal.where(:host_id => user.id).order("created_at DESC").second.price
			else
				second_price = 100
			end

			compare = (last_price / second_price - 1) * 100
  		else
  			compare = 0
  		end

	  	if compare < 0
	  		return "<span class='red'>#{compare.round}%</span>".html_safe
	  	elsif compare == 0
	  		return "<span class='grey'>#{compare.round}%</span>".html_safe
	  	else
	  		return "<span class='green'>+#{compare.round}%</span>".html_safe
	  	end
  	
  	end


end
