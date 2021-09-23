class ReviewsController < ApplicationController
  def show
    @reviews = Review.find(restaurant[:id])
  end

  # def new
  #   @review = Review.new
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  # end

  def create
    @review = Review.new(review_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.restaurant = @restaurant
    @review.user = current_user
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      flash[:alert] = "Error"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
