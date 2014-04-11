# encoding: utf-8

class StaticPagesController < ApplicationController

  def index
 	@users = User.all(:include => [:deals], :order => 'deals.id')

  end

  def future
    index! { @users = User.have_stocks }
  end
end
