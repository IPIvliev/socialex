# encoding: utf-8

class User < ActiveRecord::Base
  
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :username

  has_many :orders, :dependent => :destroy
  has_many :deals, :dependent => :destroy
  has_many :mystocks, :dependent => :destroy
  has_many :posts

  has_many :hosts, :through => :mystocks
  has_many :order_hosts, :through => :orders

# Аутентификация, либо создание нового пользователя
def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.username = auth.username
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

  def approve(amount)
    update_attribute(:pocket, pocket + amount)
  end

  def self.search(search)  
    if search  
      find(search).hosts
    else  
      scoped  
    end  
  end

end