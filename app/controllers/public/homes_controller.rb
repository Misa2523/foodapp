class Public::HomesController < ApplicationController

  def top
    #会員ステータスが有効である会員の投稿を取得（アソシエーションの関係はincludesで読み込み）
    @cooking_posts = CookingPost.includes(:customer).where(customers: { is_active: true }).order(created_at: :desc) #新しい順に投稿を表示
  end

  def about
  end
end
