class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_current_customer

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def favorites #いいねした店舗を一覧表示する
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:restaurant_id)
    @favorite_restaurants = Restaurant.find(favorites)
  end
  
  def reviews 
    @customer = Customer.find(params[:id])
    reviews = Review.where(customer_id: @customer.id).pluck(:restaurant_id)
    @review_restaurants = Restaurant.find(reviews)
  end

  private

  def set_current_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number)
  end
end
