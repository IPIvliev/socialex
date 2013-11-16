# encoding: utf-8

class StaticPagesController < ApplicationController
  def index

  @users = User.paginate(page: params[:page])

#@hi = Stock.hi
  end

end
