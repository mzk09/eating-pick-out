class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_review, only: [:edit, :update]

  def index
    @reviews = Review.all
  end

  def edit
    #@customer = @review.customer
  end

  def update
    @review.update(review_params) ? (redirect_to admin_reviews_path, notice: 'レビュー情報の更新が完了しました。') : (render :edit)
  end

  private
  def review_params
    params.require(:review).permit(:comment,:rate,:customer_id,:restaurant_id,:is_active)
  end

  def ensure_review
    @review = Review.find(params[:id])
  end

end
