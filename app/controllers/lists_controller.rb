class ListsController < ApplicationController
  def index
    @user = current_user
    @lists = @user.lists
  end

  def new
    @list = List.new
    @user = current_user
  end

  def show
    @user = current_user
    @list = List.find(params[:id])
    @markers = @list.restaurants.map do |restaurant|
      window = {info_window: render_to_string(partial: "shared/info_window", locals: {restaurant: restaurant})}
      JSON.parse(restaurant.coordinates).merge(window)
    end
  end

  def create
    raw_data = request.body.read
    data = JSON.parse(raw_data)
    # listTitle = JSON.parse(data["listTitle"])
    list_title = data["listTitle"]
    restos = JSON.parse(data["restsArr"])
    restos_id = []
    restos.each do |resto|
      restos_id << resto["restId"]
    end
    restaurant = Restaurant.find(restos_id)

    @list = List.new(name: list_title, user: current_user)
    @user = current_user
    @list.name = list_title
    (@list.restaurants << restaurant) unless @list.restaurants.include?(restaurant)
    @list.user = current_user
    if @list.save
      flash[:alert] = "Your list is saved"
      redirect_to user_lists_path(user_id: @list.user_id)
    else
      flash[:alert] = "Error"
      redirect_to results_path(@restaurant)
      # render 'shared/sidebar', restaurants: @restaurants
    end
  end

  def update
    @user = current_user
    @query = params[:query]
    @restaurant = Restaurant.find(params[:restaurant])
    @list = List.find(params[:id])
    @list.restaurants << @restaurant
    if @list.save
      flash[:alert] = "This restaurant is saved to your list"
    else
      flash[:alert] = "Error"
    end
    redirect_to restaurant_path(@restaurant, @query)
  end

  def destroy
    @user = current_user
    @list = List.find(list_params[:id])
    @list.destory
    redirect_to user_lists_path(@user)
  end

  private

  def list_params
    params.require(:list).permit(:user, :shared, :name)
  end
end
