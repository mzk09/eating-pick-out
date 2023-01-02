class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_current_customer,only: [:show, :edit, :update, :withdraw]
  before_action :check_guest_customer, only: [:edit]

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: '会員情報の更新が完了しました。'
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
    #activ_review = Review.is_active
    @customer = Customer.find(params[:id])
    reviews = Review.where(customer_id: @customer.id).pluck(:restaurant_id)
    @review_restaurants = Restaurant.find(reviews)
  end

  private

  def set_current_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted, :password, :password_confirmation)
  end

  def check_guest_customer
    guest_customer = Customer.find_by(email: "guest@example.com")
    if @customer == guest_customer
      flash[:danger] = 'ゲストユーザーはアカウント設定を変更できません'
      redirect_to customer_path(guest_customer)
    end
  end

end
