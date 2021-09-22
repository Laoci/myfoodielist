class ReviewsController < ApplicationController
  def show
    @reviews = Review.find(restaurant[:id])
  end
end
