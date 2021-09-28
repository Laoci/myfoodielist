class ExploresController < ApplicationController
  def show
    @user = current_user
    @explore = Explore.find(restaurant[:id])
  end

  def create
    @explore = Explore.new(explore_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @explore.restaurant = @restaurant
    @explore.user = current_user
    # raise
    if @explore.save
      flash[:alert] = "Marked as explored"
      redirect_to restaurant_path(@restaurant)
      # redirect_to restaurant_path(restaurant_id: @restaurant.id)
    else
      flash[:alert] = "Error"
      render :new
    end
  end

  private

  def explore_params
    params.require(:explore).permit(:explored)
  end
end
