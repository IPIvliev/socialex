# encoding: utf-8

class StaticPagesController < ApplicationController
  def index

@users = User.paginate(page: params[:page])

/ @client = Twitter::Client.new(
  :consumer_key => "8SmX3dJKoSbQq8hCOMkNAg",
  :consumer_secret => "HvdfJDBiat9zi21n7Cw0vE2hVp4jIsZHkm1JoZfk",
  :oauth_token => "38152757-Gk8sAGxNqbqoGsmcUovsPjeHttjgtzT5UuqgUPm4c",
  :oauth_token_secret => "kchFu4R9VHVLgMDCkSbV5y8XxJ5F0PGiaQ3LNRi3jJA"
)

@graph = Koala::Facebook::API.new('CAACEdEose0cBADrTOow1ntoqyGl511wWiT1xO2ZBdlEXZAqXYs4ZAV9BQao3WkZBIVZCTbOVobeFmeHi5Cg8glvmKp3nmBHkpZA6xKIerb0gzcKrfFb39IHtPD6poggy6ziN58w51mg62VeFEIcFrMziWDtZAxeDM7k6dBp6r1Ns3jhv5E3jKt6pSo9bd2YAkZBM4Gs9csyqewZDZD')
@profile = @graph.get_object("me")
@test1 = @graph.get_object("100003478442020")
@test2 = @graph.get_object("rshlegel")
@test3 = @graph.get_object("andrejs.starikovs")
@test4 = @graph.get_object("shaverm")
@test5 = @graph.get_object("aleksandr.gaponenko.9")
@test6 = @graph.get_object("margarita.dragile")

	@user = User.find(params[:id])
/
  end

   def show
    @user = User.find(params[:id])
   end
end
