# encoding: utf-8

class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page])

  end

  def show
    @user = User.find(params[:id])

    @buy_orders = Order.where("host_id = ? AND status = ?", @user.id, 1).order("price ASC")
    @sell_orders = Order.where("host_id = ? AND status = ?", @user.id, 2).order("price ASC")
  end

  def self.search
    redirect_to user_path(3)
  end

  def stocks

  end



  end