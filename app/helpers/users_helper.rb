# encoding: utf-8

module UsersHelper

# Сколько у пользователя денег
  def money(user)
      number_to_currency( user.pocket, unit: "руб.", separator: ",", delimiter: " ", format: "%n %u")
  end

end