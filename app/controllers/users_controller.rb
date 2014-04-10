# encoding: utf-8

class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page])

  end

  def show
    @user = User.find(params[:id])

    @buy_orders = Order.where("host_id = ? AND status = ?", @user.id, 1).order("price ASC")
    @sell_orders = Order.where("host_id = ? AND status = ?", @user.id, 2).order("price ASC")

    # История сделок с акциями просматриваемого пользователя
    @history = Deal.where("host_id = ?", @user)

    # Держатели акций просматриваемого пользователя
    @owners = Mystock.where("host_id = ?", @user)

  end

  def search
    if !params[:user][:uid].blank?
      @user = User.find_by_uid(params[:user][:uid])

      if @user.nil?
        User.create
      else
        redirect_to user_path(@user)
      end
    else
      redirect_to root_path
    end
  end

  def stocks

  end



  end