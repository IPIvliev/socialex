class Mystock < ActiveRecord::Base
  attr_accessible :amount, :host_id, :price, :user_id

  belongs_to :user
end
