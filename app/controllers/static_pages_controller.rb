# encoding: utf-8

class StaticPagesController < ApplicationController
  def index



@client = Twitter::Client.new(
  :consumer_key => "8SmX3dJKoSbQq8hCOMkNAg",
  :consumer_secret => "HvdfJDBiat9zi21n7Cw0vE2hVp4jIsZHkm1JoZfk",
  :oauth_token => "38152757-Gk8sAGxNqbqoGsmcUovsPjeHttjgtzT5UuqgUPm4c",
  :oauth_token_secret => "kchFu4R9VHVLgMDCkSbV5y8XxJ5F0PGiaQ3LNRi3jJA"
)

@graph = Koala::Facebook::API.new('CAABbDjcti5UBAI3sL6ZCbokm6F3fmiEf0t44LtEMAk8Ixku1kTHsebpXL5uIPPGH9PRDWqXTD0W45ThQLImCykJ89OhD247kbzGZC4v47Glp7DlGXSEvO0bfZC9UYPpRgZCYBtPGOX58Bw3iDkjnSgDVkg9QeZANhZAfa9LzWnZBrjlpMT2NqJ9M8dFd7Ru6KA4HzfmZBN5AKQZDZD')
@profile = @graph.get_object("me")
@test1 = @graph.get_object("100003478442020")
@test2 = @graph.get_object("rshlegel")
@test3 = @graph.get_object("andrejs.starikovs")
@test4 = @graph.get_object("shaverm")
@test5 = @graph.get_object("aleksandr.gaponenko.9")
@test6 = @graph.get_object("margarita.dragile")
  end

   def show
    @user = User.find(params[:id])
   end
end
