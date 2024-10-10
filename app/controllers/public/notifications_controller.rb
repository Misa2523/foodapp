class Public::NotificationsController < ApplicationController

  #ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_customer!

  #application_controller.rbで定義したメソッドを実行（ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限）すべてのアクションに対し
  before_action :restricted_guest_user

  def index
    near_expiry_home_foods = HomeFood.where("expiration_date <= ?", Date.today + 3.days).where(customer_id: current_customer.id) #@near_expiry_foodsに期限の近い食材を格納
    @near_expiry_home_foods = near_expiry_home_foods.page(params[:page]).per(10) #home_foodsにページネーションを追加
  end

  def mark_as_read
  end

  def destroy
  end
end
