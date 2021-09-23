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
    @review.save
  end

  # private

  # def review_params
  #   params.require(:review).permit(:content, :rating)
  # end
end
