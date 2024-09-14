class Public::FoodStrageAreasController < ApplicationController

  #ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_customer!

  def index
    @food_strage_areas = FoodStrageArea.all.page(params[:page]).per(10)
  end

end
