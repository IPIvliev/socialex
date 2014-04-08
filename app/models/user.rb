# encoding: utf-8

class User < ActiveRecord::Base

  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

  # has_many :selled, :foreign_key => 'seller_id', :class_name => "Stock"
  # has_many :bought, :foreign_key => 'buyer_id', :class_name => "Stock"
  # has_many :hosted, :foreign_key => 'host_id', :class_name => "Stock"

  has_many :orders, :dependent => :destroy
  has_many :deals, :dependent => :destroy
  has_many :mystocks, :dependent => :destroy

# Аутентификация, либо создание нового пользователя
def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!

    new_order(user) if !if_order?(user)
  end
end

  def self.new_order(user)
    Order.create(:user_id => user.id, :host_id => user.id, :amount => 100, :price => 100, :status => 2)
  end
   
  def self.if_order?(user)
    Order.where(:host_id => user.id).first
  end

end