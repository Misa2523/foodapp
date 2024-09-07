class Public::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    root_path #サインイン後トップページへ遷移
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path #サインアウト後トップページへ遷移
  end

end
