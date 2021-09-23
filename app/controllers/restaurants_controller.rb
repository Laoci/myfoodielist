class RestaurantsController < ApplicationController
  def index
    @query_value = params[:query]
    alert = "Sorry... We cannot find anything by #{@query_value}"

    if params[:query].present? && /\d{6}/ === @query_value
      @restaurants = Restaurant.where(postal_code: @query_value)
    elsif params[:query].present?
      sql_query = "restaurants.name @@ :query OR restaurants.address @@ :query OR restaurants.genre @@ :query"
      # @restaurants = Restaurant.joins(:items).where(sql_query, query: "%#{query_value}%").distinct
      @restaurants = Restaurant.all.where(sql_query, query: "%#{@query_value}%").distinct
    else
      @restaurants = Restaurant.all
    end

    if @restaurants.nil? || @restaurants.empty?
      flash[:alert] = alert
      return nil
    end
  end

  def show
    @query = params[:query]
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
  end

  def new
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:id])
    render :new
  end

  private

  def restaurant_params
  params.require(:restaurant).permit(:name, :address, :genre, :postal_code, :photo)
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
