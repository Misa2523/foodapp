class Public::NotificationsController < ApplicationController

  #ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_customer!

  #application_controller.rbで定義したメソッドを実行（ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限）すべてのアクションに対し
  before_action :restricted_guest_user

  def index
    # @notifications = Notification.where(user: current_user).order(created_at: :desc)
    
    #通知を表示するための処理
    # @notifications = Notification.all.order(created_at: :desc)
    
    @near_expiry_foods = HomeFood.where("expiration_date <= ?", Date.today + 3.days).where(customer_id: current_customer.id) #@near_expiry_foodsに期限の近い食材を格納
  end
  
  # def create
  #   HomeFood.check_and_create_notifications
  #   redirect_to notifications_path, notice: "消費期限の近い食材の通知があります"
  # end

  def mark_as_read
  end

  def destroy
  end
end
