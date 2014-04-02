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

    # Проверяем, создан ли этот пользоваитель. Если нет, то создаём ордер на продажу его акций
    if User.find_by_uid(user.uid).nil?
      @order = user.orders.build(:host_id => user.id, :amount => 100, :price => 100.00, :status => 2)
      @order.save
    end
  end
end

  def self.new_user_order(user)
    if !User.where(":id = ?", user.id)

    end
  end
end