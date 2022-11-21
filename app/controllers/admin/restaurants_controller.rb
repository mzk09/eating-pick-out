class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_restaurant, only: [:show, :edit, :update]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save
    redirect_to admin_restaurants_path
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,:business_time,:price,:telephone_number,:address,:is_active,:image)
  end
  
  def ensure_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
