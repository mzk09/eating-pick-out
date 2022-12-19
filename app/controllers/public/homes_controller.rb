class Public::HomesController < ApplicationController
  def top
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
    @restaurants = Restaurant.all.within(radius, origin: [gon.lat, gon.lng]).by_distance(origin: [gon.lat, gon.lng])
    gon.restaurants = @restaurants
    #gon.total_restaurants_count = @restaurants.all.count
  
  end

  private

    def geo_params
      params.require(:lat_lng).permit(:latitude, :longitude)
    end

end
