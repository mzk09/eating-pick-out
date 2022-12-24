class Public::HomesController < ApplicationController
  def top
    @genres = Genre.only_active.includes(:restaurants)
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
    @restaurants = all_restaurants.all.within(radius, origin: [gon.lat, gon.lng]).by_distance(origin: [gon.lat, gon.lng]).preload(:genre)
    gon.restaurants = @restaurants
    @q = all_restaurants.ransack(params[:q])

    #gon.total_restaurants_count = @restaurants.all.count
  end

  private

    def geo_params
      params.require(:lat_lng).permit(:latitude, :longitude)
    end

end
