class Stock < ActiveRecord::Base
  attr_accessible :host_id, :buyer_id, :amount, :seller_id, :status, :price

  belongs_to :user
  
  scope :lastbuy, :order => "price"

  def self.stockprice(user)
    stocks = Stock.where("host_id = ?", user.id)
    stocks.average('price').round(2) if !stocks.empty?
  end

end