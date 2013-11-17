class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

  has_many :selled, :foreign_key => 'seller_id', :class_name => "Stock"
  has_many :bought, :foreign_key => 'buyer_id', :class_name => "Stock"
  has_many :hosted, :foreign_key => 'host_id', :class_name => "Stock"




def self.from_omniauth(auth)

  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
    new_stock(user) if !ifstock?(user)
  end
end

def self.new_stock(user)
  Stock.create(:buyer_id => user.id, :host_id => user.id, :status => 2)
end

def self.ifstock?(user)
  !Stock.where("host_id = ? AND buyer_id = ? AND seller_id = ?", user.id, user.id, 0).first.nil?
end

end