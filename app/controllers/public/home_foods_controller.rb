class Public::HomeFoodsController < ApplicationController

  before_action :authenticate_customer! #ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）

  before_action :restricted_guest_user #application_controller.rbで定義したメソッドを実行（ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限）すべてのアクションに対し
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @home_food = HomeFood.new
  end

  def create
    @home_food = HomeFood.new(home_food_params)
    @home_food.customer_id = current_customer.id #ログイン中ユーザーのIDを設定(1:NのN側でこの設定が必要)

    if @home_food.save
      flash[:notice] = "新しい食材を登録しました"
      redirect_to home_foods_path
    else
      if HomeFood.exists?(name: @home_food.name, customer_id: current_customer.id) #入力された食材名がログイン中ユーザーによって既に登録済みだった場合
        flash.now[:alert] = "その食材は既に登録されています"
      else #食材名が登録済みではないが、正常に登録できなかった場合
        flash.now[:alert] = "食材の登録ができませんでした"
      end
      render :new
    end
  end

  def index
    #ジャンル検索で使う変数
    @genres = Genre.all

    #ソート機能で使う変数
    if params[:expiration_soon] #消費期限が早い順に並び替えたとき
      @home_foods = HomeFood.expiration_soon.includes(:customer).where(customer_id: current_customer.id).page(params[:page]).per(10)

    elsif params[:best_before_soon] #賞味期限が早い順に並び替えたとき
      @home_foods = HomeFood.best_before_soon.includes(:customer).where(customer_id: current_customer.id).page(params[:page]).per(10)

    elsif params[:created_old] #登録日が古い順に並び替えたとき
      @home_foods = HomeFood.created_old.includes(:customer).where(customer_id: current_customer.id).page(params[:page]).per(10)

    else #通常の状態
      @home_foods = HomeFood.includes(:customer).where(customer_id: current_customer.id).page(params[:page]).per(10)
    end

      #--ソート機能のコード解説--#
    # HomeFood.[スコープ名]の部分 ====> 例えば[]スコープ名]が上記のexpiration_soonの場合は、expiration_soonスコープが適用されたHomeFoodモデルのデータを取得
    # includes(:customer).where(customer_id: current_customer.id)の部分 ====> ログインユーザーが登録した情報のみ取得（アソシエーションの関係はincludesで読み込み）
    # .page(params[:page]).per(10)の部分 ====> ページネーション
  end

  def genre_search
    @genres = Genre.all #ジャンル検索で使う変数

    @genre_id = params[:genre_id] #ジャンル検索部分から送られてきたgenre_idを@genre_idに代入
    @genre = Genre.find(@genre_id) #選択されたジャンル情報を取得

    #選択されたジャンルを指定している情報、かつ、ログインユーザーが登録した情報のみ取得（アソシエーションの関係はincludesで読み込み）
    home_foods = HomeFood.includes(:customer).where(genre_id: @genre_id, customer_id: current_customer.id)

    #ソート条件をif文で適用（ジャンル検索機能とソート機能を同時に適用するため追記）
    if params[:expiration_soon]
      home_foods = home_foods.expiration_soon
    elsif params[:best_before_soon]
      home_foods = home_foods.best_before_soon
    elsif params[:created_old]
      home_foods = home_foods.created_old
    end

    @home_foods = home_foods.page(params[:page]).per(10) #home_foodsにページネーションを追加
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
      if HomeFood.exists?(name: @home_food.name, customer_id: current_customer.id) #入力された食材名がログイン中ユーザーによって既に登録済みだった場合
        flash.now[:alert] = "その食材は既に登録されています"
      else #食材名が登録済みではないが、正常に登録できなかった場合
        flash.now[:alert] = "入力項目を正しく入力してください"
      end
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
