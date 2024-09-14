class Admin::CustomersController < ApplicationController

  #管理者ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_admin!

  def posts_index
  end

  def show
  end

  def edit
  end

  def update
  end
end
