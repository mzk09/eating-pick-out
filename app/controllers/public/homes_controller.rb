class Public::HomesController < ApplicationController
  def top
    @q = Restaurant.ransack(params[:q])
    @restaurants = @q.result(distinct: true)
  end
end
