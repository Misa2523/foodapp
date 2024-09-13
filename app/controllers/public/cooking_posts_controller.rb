class Public::CookingPostsController < ApplicationController

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
      flash[:notice] = "料理の投稿ができませんでした"
      render :new
    end
  end

  def index
    @cooking_posts = CookingPost.all.page(params[:page]).per(10)
  end

  def search
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
      flash[:notice] = "入力項目を正しく入力してください"
      render :edit
    end
  end

  def destroy
    @cooking_post = CookingPost.find(params[:id])
    if @cooking_post.destroy
      flash[:notice] = "料理情報が削除されました"
      redirect_to cooking_posts_path
    else
      @cooking_post = CookingPost.find(params[:id]) #renderでeditページを描くため、editで使う変数をこのアクション内で再定義
      flash[:notice] = "料理の削除ができませんでした"
      render :edit
    end
  end

  private

  def cooking_post_params
    params.require(:cooking_post).permit(:cooking_post_image, :customer_id, :name, :introduction)
  end

  #ログインユーザーがその投稿の投稿者か判断するメソッド（自分以外が処理を実行できないように、URL直打ちで遷移できないようにする）
  def is_matching_login_user
    @cooking_post = CookingPost.find(params[:id])
    @customer = @cooking_post.customer
    unless @customer.id == current_customer.id
      redirect_to cooking_posts_path
    end
  end

end
