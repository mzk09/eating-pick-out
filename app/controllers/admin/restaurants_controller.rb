class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_restaurant, only: [:show, :edit, :update]

  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_restaurans = @genre.restaurants
    else
      all_restaurans = Restaurant.includes(:genre)
    end
    @restaurants = Restaurant.all
    @all_restaurans_count = all_restaurans.count
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save
    redirect_to admin_restaurant_path(@restaurant), notice: '店舗の登録が完了しました。'
  end

  def show
  end

  def edit
  end

  def update
    @restaurant.update(restaurant_params) ? (redirect_to admin_restaurant_path(@restaurant), notice: '店舗情報の更新が完了しました。') : (render :edit)
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,:business_time,:price,:telephone_number,:address,:is_active,:image, :latitude, :longitude,:genre_id)
  end

  def ensure_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
