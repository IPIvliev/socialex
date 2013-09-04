class StaticPagesController < ApplicationController
  def index

@client = Twitter::Client.new(
  :consumer_key => "8SmX3dJKoSbQq8hCOMkNAg",
  :consumer_secret => "HvdfJDBiat9zi21n7Cw0vE2hVp4jIsZHkm1JoZfk",
  :oauth_token => "38152757-Gk8sAGxNqbqoGsmcUovsPjeHttjgtzT5UuqgUPm4c",
  :oauth_token_secret => "kchFu4R9VHVLgMDCkSbV5y8XxJ5F0PGiaQ3LNRi3jJA"
)

@graph = Koala::Facebook::API.new('CAACEdEose0cBAITy53T1Ebvr8BRhUJguCN2ZCm9ZBCV88K9csjTrxIZBqybLKPU6iyLZCSvIQhFAFuTIYSN8zrZATk4ypZBAqWkzDLYR2xZBee6f9ljdXWGJhwaSDBe9HdqnDYCMZBtvHb82RuNhXzYYrZBmGabwh8ZCnZCMDSW7nKopoZC3pyPwKHZCH2BNrcwcFWPp880HNPPpr2gZDZD')
@profile = @graph.get_object("me")
@test1 = @graph.get_object("shaverm")
  end
end
