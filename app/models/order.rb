class Order < ActiveRecord::Base
  attr_accessible :amount, :host_id, :price, :status, :user_id

  validates_numericality_of :amount, :only_integer => true, :greater_than_or_equal_to => 0, :in => 1..100, :presence => true, :notice => "invalid fundays"
  validates_numericality_of :price, :only_integer => true, :greater_than_or_equal_to => 0, :min => 1, :presence => true, :notice => "invalid fundays"

  belongs_to :user
  belongs_to :order_host, class_name: "User", foreign_key: "host_id"
end