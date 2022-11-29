class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!, only:[:create,:destroy
]

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    review = current_customer.reviews.new(review_params)
    review.restaurant_id = restaurant.id
    review.save!
    redirect_to restaurant_path(restaurant)
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to restaurant_path(params[:restaurant_id])
  end

  private

  def review_params
    params.require(:review).permit(:comment,:rate,:customer_id,:restaurant_id)
  end
end
