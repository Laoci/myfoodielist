class TagsController < ApplicationController
  # def index
  #   @tags = Tag.all
  # end

  def show
    @user = current_user
    @tags = Tag.find(restaurant[:id])
  end

  # def new
  #   @tag = Tag.new
  #   @restaurant = Restaurant.find(params[:format])
  #   @user = current_user
  # end

  def create
    @tag = Tag.new(tag_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tag.restaurant = @restaurant
    @tag.user = current_user
    # raise
    if @tag.save
      flash[:alert] = "Your tag is saved"
      redirect_to restaurant_path(@restaurant)
      # redirect_to restaurant_path(restaurant_id: @restaurant.id)
    else
      flash[:alert] = "Error"
      render :new
    end
  end

  # def destroy
  #   @user = current_user
  #   @list = List.find(list_params[:id])
  #   @list.destory
  #   redirect_to user_lists_path(@user)
  # end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
