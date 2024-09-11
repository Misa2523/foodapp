class Public::FoodStrageAreasController < ApplicationController

  def index
    @food_strage_areas = FoodStrageArea.all.page(params[:page]).per(10)
  end

end
