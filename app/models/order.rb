class Order < ActiveRecord::Base
  attr_accessible :amount, :host_id, :price, :status, :user_id

  validates :amount, presence: true
  validates :price, presence: true

  belongs_to :user
end
