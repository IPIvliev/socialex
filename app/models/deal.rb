class Deal < ActiveRecord::Base
  attr_accessible :amount, :host_id, :price, :seconduser_id, :status, :user_id
end
