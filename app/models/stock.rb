class Stock < ActiveRecord::Base
  attr_accessible :host_id, :buyer_id, :amount, :seller_id, :status

  belongs_to :user
  
end