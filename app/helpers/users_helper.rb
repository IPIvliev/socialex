# encoding: utf-8

module UsersHelper

# Сколько денег
  def money(summa)
    number_to_currency( summa, unit: "руб.", separator: ",", delimiter: " ", format: "%n %u")
  end

  def stocks_amount(amount)
	Russian.pluralize(amount, "акция", "акции", "акций")
  end
  
end