# encoding: utf-8

class StaticPagesController < ApplicationController

  def index
 	@users = User.all(:include => [:deals], :order => 'deals.id')

  end

end
