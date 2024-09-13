class ApplicationController < ActionController::Base

  #ゲストユーザーかどうか判断(ヘッダーのボタン非表示設定に使用)
  def guest?
    current_customer.email == "guest@example.com"
  end

  helper_method :guest? #guest?メソッドをヘルパーメソッドに指定し、ビューファイルで呼び出せるようにする

end
