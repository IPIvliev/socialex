# encoding: utf-8

class StaticPagesController < ApplicationController
  def index

@client = Twitter::Client.new(
  :consumer_key => "8SmX3dJKoSbQq8hCOMkNAg",
  :consumer_secret => "HvdfJDBiat9zi21n7Cw0vE2hVp4jIsZHkm1JoZfk",
  :oauth_token => "38152757-Gk8sAGxNqbqoGsmcUovsPjeHttjgtzT5UuqgUPm4c",
  :oauth_token_secret => "kchFu4R9VHVLgMDCkSbV5y8XxJ5F0PGiaQ3LNRi3jJA"
)

@graph = Koala::Facebook::API.new('CAABbDjcti5UBAAmE0Vty2gdhi8OvYI0y9mhwEmuLguJFSvXEUi8YmUfkVUqQ4eLdTfyMWfJ79Jr2B0Pi1ZCkGcAEYwEZA6wNqtRwuTj7r8rTlrbcZBSz5fbmpjmmMVe2FdYdZARq5ZCKTE9qZCyohFKhGcrRuZAdVGvDlHVi1RhmZCyzSZBhDHK0XYoA8PIG0xO0es3hrv0b0AgZDZD')
@profile = @graph.get_object("me")
@test1 = @graph.get_object("100003478442020")
@test2 = @graph.get_object("rshlegel")
@test3 = @graph.get_object("andrejs.starikovs")
@test4 = @graph.get_object("shaverm")
@test5 = @graph.get_object("aleksandr.gaponenko.9")
@test6 = @graph.get_object("margarita.dragile")
  end
end
