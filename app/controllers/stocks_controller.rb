class StocksController < ApplicationController


  def create
    @stock = Stock.new(params[:stock])
    if @stock.save
      flash[:success] = "Поздравляем Вас с успешной регистрацией. Теперь Вы можете подать заявку"
      redirect_to new_request_path
    else
      flash.now[:error] = 'Регистрация не удалась. Вы не заполнили, либо не правильно заполнили одно из полей.'
      render 'new'
    end
  end

end
