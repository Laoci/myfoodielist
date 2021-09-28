class RestaurantsController < ApplicationController
  def index
    @query_value = params[:query]
    @sort_by = params[:sort_by]
    @filter_by = params[:filter_by]
    @sort_order = params[:sort_order]
    alert = "#{@query_value} is not found. Please try another search."

    # Keyword search result
    if params[:query].present? && /\d{6}/ === @query_value
      @restaurants = Restaurant.where(postal_code: @query_value)
    elsif params[:query].present?
      @sql_query = "restaurants.name @@ :query OR restaurants.address @@ :query OR restaurants.genre @@ :query"
      @restaurants = Restaurant.all.where(@sql_query, query: "%#{@query_value}%").distinct
    else
      @restaurants = Restaurant.all
    end
    if @restaurants.nil? || @restaurants.empty?
      flash[:alert] = alert
    end

    # Filtering
    filter_restaurants if @filter_by.present?

    # Sorting
    sort_restaurants if @sort_by.present?
  end

  def show
    @query = params[:query]
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    @tag = Tag.new
  end

  def new
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    @tag = Tag.new
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

  def filter_restaurants
    filter_query = "tags.name @@ :sub_query"
    @restaurants = @restaurants.joins(:tags).where(filter_query, sub_query: "%#{@filter_by}%").distinct
  end

  def sort_restaurants
    if (@sort_by == "name" || @sort_by == "genre") && @sort_order.present?
      @restaurants = @restaurants.order("#{@sort_by} #{@sort_order.upcase}")
    elsif !@sort_order.present?
      @restaurants = @restaurants.order("#{@sort_by} ASC")
    elsif @sort_order == "asc"
      @restaurants = @restaurants.to_a.sort_by { |restaurant| restaurant.avg_rating }
    else
      @restaurants = @restaurants.to_a.sort_by { |restaurant| restaurant.avg_rating }.reverse!
    end
  end
end
