# encoding: utf-8

class StocksController < ApplicationController


  def create
    @stock = Stock.new(params[:stock])
    if @stock.save
      flash[:success] = "Поздравляем Вас с успешной регистрацией. Теперь Вы можете подать заявку"
      redirect_to user_path(params[:stock][:buyer_id])
    else
      flash.now[:error] = 'Регистрация не удалась. Вы не заполнили, либо не правильно заполнили одно из полей.'
      render 'new'
    end
  end

def deal
  a = Stock.find(params[:stock][:stockid])
  result = a.amount - params[:stock][:amount].to_i
  a.update_attributes(:amount => result)
  Stock.create(:host_id => a.host_id, :buyer_id => params[:stock][:buyer_id], :seller_id => a.buyer_id, :amount => params[:stock][:amount])
  redirect_to user_path(params[:stock][:buyer_id])
end

end
