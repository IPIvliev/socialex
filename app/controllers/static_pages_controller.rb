# encoding: utf-8

class StaticPagesController < ApplicationController
  def index
 	@users = User.paginate(page: params[:page])
  end

end
