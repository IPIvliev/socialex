class Mystock < ActiveRecord::Base
  attr_accessible :amount, :host_id, :price, :user_id

  belongs_to :user
  belongs_to :host, class_name: "User", foreign_key: "host_id"
end
