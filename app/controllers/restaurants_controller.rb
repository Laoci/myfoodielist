class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    # query_value = params[:query]
    # alert = "Sorry... We cannot find anything by #{query_value}"
    # if params[:query].present? && /\d{6}/ === query_value
    #   query_value = query_value.to_i
    #   @restaurants = Restaurant.where(postal_code: query_value)
    # else
    #   return nil
    # end

    # if @restaurants.empty? || query_value.to_s.empty?
    #   redirect_to root_path, alert: alert
    #   return nil
    # end
  end

  def new
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.find(params[:id])
    render :new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def restaurant_params
  params.require(:restaurant).permit(:name, :address, :genre, :postal_code, :photo)
  end
end
