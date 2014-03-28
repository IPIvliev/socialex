# encoding: utf-8

module UsersHelper

# Сколько у пользователя денег
  def money(user)
      number_to_currency( user.pocket, unit: "руб.", separator: ",", delimiter: " ", format: "%n %u")
  end

  def compare(user)
  	compare = Order.where(:host_id => user.id).order("price ASC").first.price.round(2) / Order.where(:host_id => user.id).order("price ASC").second.price.round(2)

  	if compare <= 1
  		return "<span class='red'>#{compare.round(2)}</span>".html_safe
  	else 
  		return "<span class='green'>#{compare.round(2)}<span>".html_safe
  	end
  	
  end
end