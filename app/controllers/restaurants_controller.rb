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
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:id])
    # @review = Review.new(review_params)
    # @restaurant = Restaurant.find(params[:restaurant_id])
    # @review.restaurant = @restaurant
    # @review.save
    render :new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
  end

  private

  def restaurant_params
  params.require(:restaurant).permit(:name, :address, :genre, :postal_code, :photo)
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
