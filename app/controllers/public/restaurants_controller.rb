class Public::RestaurantsController < ApplicationController
  def show
    @genres = Genre.only_active
    @restaurant = Restaurant.where_genre_active.find(params[:id])

    @review = Review
    @review_avg = Review.where(restaurant_id: params[:id]).average(:rate)
  end

  def index
    @genres = Genre.only_active
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_restaurants = @genre.restaurants
    else
      all_restaurants = Restaurant.includes(:genre)
    end
    @active_restaurants = all_restaurants.active_restaurant
    @q = @active_restaurants.ransack(params[:q])
    @restaurants = @q.result(distinct: true)
    @all_restaurants_count = all_restaurants.count
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,:business_time,:price,:telephone_number,:address,:is_active,:image, :latitude, :longitude, :genre_id)
  end

end
