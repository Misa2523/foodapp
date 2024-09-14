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

end
