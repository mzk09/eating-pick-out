class Public::RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review
    @review_avg = Review.where(restaurant_id: params[:id]).average(:rate)
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,:business_time,:price,:telephone_number,:address,:is_active,:image)
  end

end
