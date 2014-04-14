# encoding: utf-8

class RobokassaController < ApplicationController

  include ActiveMerchant::Billing::Integrations

  skip_before_filter :verify_authenticity_token # skip before filter if you chosen POST request for callbacks

  before_filter :create_notification
  before_filter :find_payment

  # Robokassa call this action after transaction
  def paid
    #if @notification.acknowledge # check if it’s genuine Robokassa request
      #@user.approve! # project-specific code
      render :text => @notification.success_response
    #else
     #head :bad_request
    #end
  end

  # Robokassa redirect user to this action if it’s all ok !@user.approved? &&
  def success
    if  @notification.acknowledge
      @user.approve(@notification)
    end

    redirect_to @user, :notice => "Ваш взнос успешно принят!"
  end
  # Robokassa redirect user to this action if it’s not
  def fail
    redirect_to @user, :notice => "Оплата не удалась!"
  end

  private

  def create_notification
    @notification = Robokassa::Notification.new(request.raw_post, :secret => "OdergiesSE1")
  end

  def find_payment
    @user = User.find(@notification.item_id)
  end
end
