class Admin::HomesController < ApplicationController

  #管理者ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_admin!

  def top
    @customers = Customer.all.page(params[:page]).per(10)
  end
end
