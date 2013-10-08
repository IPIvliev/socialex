class Stock < ActiveRecord::Base
  attr_accessible :host_id, :buyer_id, :amount

  belongs_to :user
  
end