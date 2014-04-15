# encoding: utf-8

class StaticPagesController < ApplicationController

  def index
 	@users = User.search(params[:search]).order("price DESC").paginate(:page => params[:page], :per_page => 12)

  end

end
