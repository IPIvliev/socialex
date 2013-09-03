# encoding: utf-8

class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])

  end

  def new
    @user = User.new
  end

    def create
    @user = User.new(params[:user])
    if @user.save
    	sign_in @user
      flash[:success] = "Поздравляем Вас с успешной регистрацией. Теперь Вы можете подать заявку"
      redirect_to new_request_path
    else
      flash.now[:error] = 'Регистрация не удалась. Вы не заполнили, либо не правильно заполнили одно из полей.'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Данные обновлены."
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

   def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь уничтожен."
    redirect_to users_url
  end

  def man
    @man = User.find(params[:id])
    @man.toggle!(:manager)
    redirect_to users_path
  end

    def adm
    @adm = User.find(params[:id])
    @adm.toggle!(:admin)
    redirect_to users_path
  end

end