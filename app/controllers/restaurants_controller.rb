class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show]

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    @hash = Gmaps4rails.build_markers([@restaurant]) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow render_to_string(partial: "map/infowindow", locals: { :restaurant => restaurant})
      marker.picture(url: view_context.asset_path("orange-dot.png"),
                     width: 32,
                     height: 32,
                     )
      marker.json({title: restaurant.name})
    end
  end
end
