module ApplicationHelper

  #ゲストユーザーかどうか判断
  def guest?
    current_customer.email == "guest@example.com"
  end

end
