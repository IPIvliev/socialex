# encoding: utf-8

class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

  # has_many :selled, :foreign_key => 'seller_id', :class_name => "Stock"
  # has_many :bought, :foreign_key => 'buyer_id', :class_name => "Stock"
  # has_many :hosted, :foreign_key => 'host_id', :class_name => "Stock"

  has_many :orders


# Аутентификация, либо создание нового пользователя
def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
  end
end


# Сколько у пользователя денег
  def money?
    if pocket.blank?
      return "0,00 руб."
    else
      number_to_currency( pocket, unit: "руб.", separator: ",", delimiter: "", format: "%n %u")
    end
  end

end