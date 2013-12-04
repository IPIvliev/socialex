# encoding: utf-8

class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page])

  end

  def show
    @user = User.find(params[:id])

    @buyers = User.find(params[:id])
    @users = User.all

    @stockprice = Stock.stockprice(@user)

    @stock = Stock.new

    @stocksbuy = Stock.where("host_id = ? AND amount > ? AND status = ?", @user.id, 0, 2).lastbuy
    @stockssell = Stock.where("host_id = ? AND amount > ? AND status = ?", @user.id, 0, 1).lastbuy

    @stockamount = Stock.where("host_id = ?", @user.id)

    @userstock = User.howmany
  end

  def self.search
    redirect_to user_path(3)
  end

  def self.howmany
    s = Stock.where('host_id = ?, buyer_id = ?', @user.id, 3)
    s.sum(:amount)
  end

  end