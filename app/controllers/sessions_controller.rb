# encoding: utf-8
class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to new_request_path
    else
      flash.now[:error] = 'Вы неверно ввели e-mail или пароль'
      render 'new'
    end
  end



  def destroy
    sign_out
    redirect_to root_url
  end
end