class OrdersController < ApplicationController

  def purchase
    @course = Course.friendly.find(params[:id])
  end

  def ordersuccess
  end

end
