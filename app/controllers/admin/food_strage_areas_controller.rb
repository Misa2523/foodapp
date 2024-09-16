class Admin::FoodStrageAreasController < ApplicationController

  #管理者ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_admin!

  def new
    @food_strage_area = FoodStrageArea.new
  end

  def create
    @food_strage_area = FoodStrageArea.new(food_strage_area_params)
    if @food_strage_area.save
      flash[:notice] = "新しい食材を登録しました"
      redirect_to admin_food_strage_areas_path
    else
      flash[:notice] = "食材の登録ができませんでした"
      render :new
    end
  end

  def index
    @food_strage_areas = FoodStrageArea.all.page(params[:page]).per(10)
  end

  def destroy
    @food_strage_area = FoodStrageArea.find(params[:id])
    if @food_strage_area.destroy
      flash[:notice] = "食材保存場所が削除されました"
      redirect_to admin_food_strage_areas_path
    else
      flash[:notice] = "食材保存場所の削除の削除ができませんでした"
      redirect_to admin_food_strage_areas_path
    end
  end

  def edit
    @food_strage_area = FoodStrageArea.find(params[:id])
  end

  def update
    @food_strage_area = FoodStrageArea.find(params[:id])
    if @food_strage_area.update(food_strage_area_params)
      flash[:notice] = "食材保存場所情報が更新されました"
      redirect_to admin_food_strage_areas_path
    else
      @food_strage_area = FoodStrageArea.find(params[:id]) #renderでeditページを描くため、editで使う変数をこのアクション内で再定義
      flash[:notice] = "入力項目を正しく入力してください"
      render :edit
    end
  end

  private

  def food_strage_area_params
    params.require(:food_strage_area).permit(:name, :place)
  end

end
