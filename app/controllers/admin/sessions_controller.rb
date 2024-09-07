class Admin::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    admin_path #サインイン後、管理者トップページへ遷移
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path #サインアウト後、管理者ログインページへ遷移
  end

end
