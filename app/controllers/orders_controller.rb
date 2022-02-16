class OrdersController < ApplicationController

  before_action :authenticate_user

  def purchase
    @course = Course.friendly.find(params[:id])
  end

  def ordersuccess; end

end
