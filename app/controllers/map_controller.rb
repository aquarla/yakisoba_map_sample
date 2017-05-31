class MapController < ApplicationController
  def index
    @prefectures = Prefecture.order(:id)

    if q = params[:q]
      @restaurants = Restaurant.where('name LIKE ?', '%'+q+'%').order(:id => "desc")
    elsif code = params[:code]
      @prefecture = Prefecture.where(:code => code).first
      if @prefecture
        @restaurants = @prefecture.restaurants.order(:id => "desc")
      end
    else
      @restaurants = Restaurant.order(:id => "desc")
    end
    @hash = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
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
