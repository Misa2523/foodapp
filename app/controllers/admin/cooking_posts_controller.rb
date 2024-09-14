class Admin::CookingPostsController < ApplicationController

  #管理者ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_admin!

  def index
    @cooking_posts = CookingPost.all.page(params[:page]).per(10)
  end

  def show
    @cooking_post = CookingPost.find(params[:id])
    @customer = @cooking_post.customer
  end
end
