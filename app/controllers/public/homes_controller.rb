class Public::HomesController < ApplicationController

  def top
  end

  def map_search
    @genres = Genre.only_active.includes(:restaurants).sort
    @random = @genres.sample(1)
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_restaurants = @genre.restaurants
    else
      all_restaurants = Restaurant.includes(:genre)
    end
    # @q = Restaurant.ransack(params[:q])
    # @restaurants = @q.result(distinct: true)
    if params[:lat_lng]
      gon.lat = geo_params[:latitude].to_f
      gon.lng = geo_params[:longitude].to_f
    else
      # default value
      gon.lat = 35.681236
      gon.lng = 139.767125
    end
    @latitude = gon.lat
    @longitude = gon.lng
    radius = 1.5
    @active_restaurants = all_restaurants.active_restaurant
    @restaurants = @active_restaurants.within(radius, origin: [gon.lat, gon.lng]).by_distance(origin: [gon.lat, gon.lng])
    gon.restaurants = @restaurants
    gon.genres = @genres
    #gon.total_restaurants_count = @restaurants.all.count
  end

  private

    def geo_params
      params.require(:lat_lng).permit(:latitude, :longitude)
    end

end
