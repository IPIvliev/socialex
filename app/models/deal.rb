# encoding: utf-8

class Deal < ActiveRecord::Base
	attr_accessible :amount, :host_id, :price, :seconduser_id, :status, :user_id

	belongs_to :user

	def buy_sell
		case status
		when 1
			return "Покупка"
		when 2 
			return "Продажа"
		end
	end
end
