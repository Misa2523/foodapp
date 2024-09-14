class ApplicationController < ActionController::Base

  #以下、コントローラで呼び出すメソッドのためヘルパーメソッドではなくここに記述

  #ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限
  def restricted_guest_user
    @customer = current_customer
    if @customer.email == "guest@example.com"
      flash[:notice] = "ゲストユーザーはご指定のページ遷移/処理はできません"
      redirect_to cooking_posts_path
    end
  end

  def logged_in?
    current_customer.present? #current_customerが存在するかどうかでログイン状態を判定
  end
  #ログイン前ユーザーによるURL直打ちでの、ページ遷移/処理を制限
  def restricted_not_login_user
    unless logged_in?
      flash[:notice] = "ご指定のページ遷移/処理をするには、新規会員登録orログインをしてください"
      redirect_to root_path
    end
  end

end
