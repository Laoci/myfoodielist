class CalendarsController < ApplicationController
  def index
    # show all calendars for the current_user
    @calendars = current_user.calendars
  end

  def create
    # receives date
    @calendar = Calendar.new(calendar_params)
    @calendar.user = current_user
    @calendar.restaurant = Restaurant.find(params[:restaurant_id])

    if @calendar.save
      redirect_to calendars_path
    else
      render 'restaurants/show'
    end
  end

  private

  def calendar_params
    params.require(:calendar).permit(:scheduled_date)
  end
end
