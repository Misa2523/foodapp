include ApplicationHelper #ApplicationHelperモジュールを読み込む

class Public::HomeFoodsController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:index] #helpers/application_helper.rbで定義したメソッドを実行（ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限

  def new
    @home_food = HomeFood.new
  end

  def create
    @home_food = HomeFood.new(home_food_params)
    @home_food.customer_id = current_customer.id #ログイン中の顧客のIDを設定(1:NのN側でこの設定が必要)

    if @home_food.save
      flash[:notice] = "新しい食材を登録しました"
      redirect_to home_foods_path
    else
      flash[:notice] = "食材の登録ができませんでした"
      render :new
    end
  end

  def index
    @home_foods = HomeFood.all.page(params[:page]).per(10)
  end

  def edit
    @home_food = HomeFood.find(params[:id])
  end

  def update
    @home_food = HomeFood.find(params[:id])
    if @home_food.update(home_food_params)
      flash[:notice] = "食材情報が更新されました"
      redirect_to home_foods_path
    else
      @home_food = HomeFood.find(params[:id]) #renderでeditページを描くため、editで使う変数をこのアクション内で再定義
      flash[:notice] = "入力項目を正しく入力してください"
      render :edit
    end
  end

  def destroy
    @home_food = HomeFood.find(params[:id])
    if @home_food.destroy
      flash[:notice] = "食材が削除されました"
      redirect_to home_foods_path
    else
      flash[:notice] = "食材の削除ができませんでした"
      redirect_to home_foods_path
    end
  end

  private

  def home_food_params
    params.require(:home_food).permit(:customer_id, :genre_id, :name, :amount, :expiration_date, :best_before_date)
  end

  #ログインユーザーがその食材の登録者か判断するメソッド（自分以外が処理を実行できないようにする）
  def is_matching_login_user
    @home_food = HomeFood.find(params[:id])
    @user = @home_food.customer
    unless @user.id == current_customer.id
      redirect_to home_foods_path
    end
  end

end
