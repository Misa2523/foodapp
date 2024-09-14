class Public::FoodStrageAreasController < ApplicationController

  #application_controller.rbで定義したメソッドを実行（ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限
  before_action :restricted_not_login_user, only: [:index]

  def index
    @food_strage_areas = FoodStrageArea.all.page(params[:page]).per(10)
  end

end
