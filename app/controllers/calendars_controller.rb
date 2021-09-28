class CalendarsController < ApplicationController
  def index
    @user = current_user
    @calendar = Calendar.list
  end

  def new
    @calendar = Calendar.new
    @user = current_user
  end

  def show
    @user = current_user
    @calendar = Calendar.where(:user_id, current_user.id)
  end
  def create
    @calendar = Calendar.new(calendar_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @calendar.restaurant = @restaurant
    @calendar.user = current_user
    if @calendar.save
      redirect_to restaurant_path(@restaurant)
    else
      flash[:alert] = "Error"
    end
  end

  private

  def calendar_params
    params.require(:calendar).permit(:starts_at)
  end
end
