# encoding: utf-8

class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page])

  end

  def show
    @user = User.find(params[:id])

    @buyers = User.find(params[:id])

  end

  def self.search
    redirect_to user_path(3)
  end

  def stocks

  end



  end