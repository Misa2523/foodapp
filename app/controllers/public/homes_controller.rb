class Public::HomesController < ApplicationController
  def top
    @cooking_posts = CookingPost.all.order(created_at: :desc) #新しい順に投稿を表示
  end

  def about
  end
end
