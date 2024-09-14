module ApplicationHelper

  #ビューファイルで呼び出すメソッドのためここに記述
  #ゲストユーザーかどうか判断
  def guest?
    current_customer.email == "guest@example.com"
  end

end
