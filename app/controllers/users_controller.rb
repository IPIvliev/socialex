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
    # Проверяем, передано ли из форму поиска значение
    if !params[:user][:uid].blank?

      # Проверяем, есть ли данный пользователь в Facebook ВНИМАНИЕ!!! НЕ РАБОТАЕТ ПРОВЕРКА НА ОШИБКУ   
      if new_user = FbGraph::User.fetch(params[:user][:uid])

      # Ищем пользователя среди уже зарегистрированных
      user = User.find_by_uid(new_user.identifier)

      # Если пользователья ещё не в SocialEx
        if user.nil?

            user = User.create(:uid => new_user.identifier, :provider => "facebook", :username => new_user.username, :name => new_user.name)
            User.new_order(user) if !User.if_order?(user)

            redirect_to user_path(user)

        else
          redirect_to user_path(user)
        end
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def stocks

  end



  end