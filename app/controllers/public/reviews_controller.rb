class Public::ReviewsController < ApplicationController

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    review = current_customer.reviews.new(review_params)
    review.restaurant_id = restaurant.id
    review.save
    redirect_to restaurant_path(restaurant)
  end

  private

  def review_params
    params.require(:review).permit(:comment,:rate)
  end
end
