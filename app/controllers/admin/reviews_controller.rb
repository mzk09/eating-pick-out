class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_review, only: [:edit, :update]

  def index
    @reviews = Review.all
  end

  def edit
    @customer = @reviews.customer
  end

  def update
    @review.update(review_params) ? (redirect_to admin_review_path(@review)) : (render :edit)
  end

  private
  def review_params
    params.require(:review).permit(:comment,:rate,:customer_id,:restaurant_id)
  end

  def ensure_review
    @reviews = Review.find(params[:id])
  end

end
