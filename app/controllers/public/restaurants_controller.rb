class Public::RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,:business_time,:price,:telephone_number,:address,:is_active,:image)
  end

end
