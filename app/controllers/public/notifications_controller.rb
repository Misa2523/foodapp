include ApplicationHelper #ApplicationHelperモジュールを読み込む

class Public::NotificationsController < ApplicationController

  #helpers/application_helper.rbで定義したメソッドを実行（ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限
  before_action :restricted_guest_user, only: [:index, :mark_as_read, :destroy]

  def index
  end

  def mark_as_read
  end

  def destroy
  end
end
