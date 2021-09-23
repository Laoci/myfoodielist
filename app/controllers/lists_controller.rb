class ListsController < ApplicationController
  def index
    @lists = Restaurant.all
  end

  def new
    @list = List.find(params[:id])
  end
end
