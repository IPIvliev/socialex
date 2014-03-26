class Order < ActiveRecord::Base
  attr_accessible :amount, :host_id, :price, :status, :user_id

  belongs_to :user
end
