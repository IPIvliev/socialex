# encoding: utf-8

class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page])
    
  end

  def show
    @user = User.find(params[:id])
    @buyers = User.find(params[:id])
    @users = User.all

    @stock = Stock.new
  end




end