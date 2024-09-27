class Public::CookingPostsController < ApplicationController

  before_action :authenticate_customer! #ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（すべてアクセスできないよう設定）

  before_action :restricted_guest_user, only: [:new, :create, :edit, :update, :destroy] #application_controller.rbで定義したメソッドを実行（ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限）

  #private内で定義したメソッドを実行
  before_action :cancel_membership, only: [:show] #退会している会員の投稿一覧ページは閲覧不可にする
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @cooking_post = CookingPost.new
  end

  def create
    @cooking_post = CookingPost.new(cooking_post_params)
    @cooking_post.customer_id = current_customer.id #ログイン中の顧客のIDを設定(1:NのN側でこの設定が必要)

    if @cooking_post.save
      flash[:notice] = "新しい料理を投稿しました"
      redirect_to cooking_post_path(@cooking_post.id)
    else
      flash.now[:alert] = "料理の投稿ができませんでした"
      render :new
    end
  end

  def index
    #会員ステータスが有効である会員の投稿を取得（アソシエーションの関係はincludesで読み込み）
    @cooking_posts = CookingPost.includes(:customer).where(customers: { is_active: true }).order(created_at: :desc).page(params[:page]).per(10) #orderメソッドで投稿された順に並べる
  end

  def search
    @content = params["content"] #_search.html.erbにて入力したキーワードを@contentに代入
    @condition = params["condition"] #_search.html.erbにて選択した検索カラムを@conditionに代入
    @method = "partial" #条件を部分一致に固定

    # 検索結果を@recordsに代入（search_forメソッドはprivate内に記述)
    @records = search_for(@content, @condition, @method)
  end

  def show
    @cooking_post = CookingPost.find(params[:id])
    @customer = @cooking_post.customer
  end

  def edit
    @cooking_post = CookingPost.find(params[:id])
  end

  def update
    @cooking_post = CookingPost.find(params[:id])
    if @cooking_post.update(cooking_post_params)
      flash[:notice] = "料理情報が更新されました"
      redirect_to cooking_post_path(@cooking_post.id)
    else
      @cooking_post = CookingPost.find(params[:id]) #renderでeditページを描くため、editで使う変数をこのアクション内で再定義
      flash.now[:alert] = "入力項目を正しく入力してください"
      render :edit
    end
  end

  def destroy
    @cooking_post = CookingPost.find(params[:id])
    if @cooking_post.destroy
      flash[:notice] = "料理情報が削除されました"
      redirect_to posts_index_customers_path(current_customer.id) #自分の投稿一覧ページへ遷移
    else
      @cooking_post = CookingPost.find(params[:id]) #renderでeditページを描くため、editで使う変数をこのアクション内で再定義
      flash.now[:alert] = "料理の削除ができませんでした"
      render :edit
    end
  end

  private

  def cooking_post_params
    params.require(:cooking_post).permit(:cooking_post_image, :customer_id, :name, :introduction)
  end

  #退会している会員の情報は閲覧不可にする（特定会員の投稿一覧ページ、投稿詳細ページに反映させる：URL直打ち対策）
  def cancel_membership
    @cooking_post = CookingPost.find(params[:id]) #URLの投稿情報を取得
    @customer = @cooking_post.customer
    if @customer.is_active == false #会員ステータスがfalse(退会ユーザー)だったら
      flash[:notice] = "ご指定の会員の投稿は閲覧できません"
      redirect_to cooking_posts_path
    end
  end

  #ログインユーザーがその投稿の投稿者か判断する（自分以外が処理を実行できないように、URL直打ちで遷移できないようにする）
  def is_matching_login_user
    @cooking_post = CookingPost.find(params[:id])
    @customer = @cooking_post.customer
    unless @customer.id == current_customer.id
      redirect_to cooking_posts_path
    end
  end

  # キーワード検索用のメソッド
  def search_for(content, condition, method)
    if condition == "name" #料理名カラムが選択された場合
      CookingPost.includes(:customer).where(customers: { is_active: true }) #会員ステータスが有効である会員の投稿を取得（アソシエーションの関係はincludesで読み込み）
                  .where("cooking_posts.name LIKE ?", "%"+content+"%") #部分一致

    elsif condition == "introduction" #紹介文カラムが選択された場合
      CookingPost.includes(:customer).where(customers: { is_active: true })
                  .where("introduction LIKE ?", "%"+content+"%") #部分一致
    end
  end

end
