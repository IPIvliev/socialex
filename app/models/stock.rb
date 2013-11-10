class Stock < ActiveRecord::Base
  attr_accessible :host_id, :buyer_id, :amount, :seller_id, :status

  belongs_to :user
  
  def self.stockprice(user)
    stocks = Stock.where("host_id = ?", user.id)
    stocks.average('price').round(2)\
  end

def buy(stockid, buyer, amount)
  a = Stock.find(stockid)
  result = a.amount - amount
  a.update_attributes(:amount => result)
  Stock.create(:host_id => a.host_id, :buyer_id => buyer, :seller_id => a.buyer_id, :amount => amount)
end

def sell

  end


end