class Public::ReviewsController < ApplicationController

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    comment = current_customer.reviews.new(review_params)
    comment.restaurant_id = restaurant.id
    comment.save
    redirect_to restaurant_path(restaurnat)
  end

  private

  def review_params
    params.require(:review).permit(:comment,:rate)
  end
end
