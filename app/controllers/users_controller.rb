class UsersController < ApplicationController
  def mapping
    @restaurants = current_user.lists[0].restaurants
    @markers = @restaurants.map do |restaurant|
      window = {info_window: render_to_string(partial: "shared/info_window", locals: {restaurant: restaurant})}
      JSON.parse(restaurant.coordinates).merge(window)
    end
    render 'pages/map'
  end
end
