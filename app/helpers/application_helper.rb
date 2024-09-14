module ApplicationHelper

  #ゲストユーザーかどうか判断
  def guest?
    current_customer.email == "guest@example.com"
  end

   #ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限
  def ensure_guest_user
    @customer = current_customer
    if @customer.email == "guest@example.com"
      flash[:notice] = "ゲストユーザーはご指定のページ遷移/処理はできません"
      redirect_to cooking_posts_path
    end
  end

end
