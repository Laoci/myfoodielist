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
  end

  def create
    @list = List.new(list_params)
    @user = current_user
    @list.user = current_user
    if @list.save
      flash[:alert] = "Your list is saved"
      redirect_to user_lists_path(user_id: @list.user_id)
    else
      flash[:alert] = "Error"
      render :new
    end
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
