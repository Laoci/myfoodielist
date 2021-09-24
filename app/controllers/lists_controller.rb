class ListsController < ApplicationController
  def index
    @user = current_user
    @lists = @user.lists
  end

  def show
    @user = current_user
    @list = List.find(params[:id])
  end

  def create
    @user = current_user
    @list = List.new(list_params)
    @list.save ? (flash[:notice] = "Your list is saved") : (flash[:alert] = "Sorry, an error occured")
  end

  def destory
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
