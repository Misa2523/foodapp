class Public::NotificationsController < ApplicationController

  #ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_customer!

  #application_controller.rbで定義したメソッドを実行（ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限）すべてのアクションに対し
  before_action :restricted_guest_user

  def index
    #消費期限の近い食材
    @near_expiry_home_foods = HomeFood.where("expiration_date <= ?", Date.today + 2.days) #今日から2日以内の期限であるレコードを取得（? はプレースホルダーで、後に続く"Date.today + 2.days"の値がこの条件に適用される）
                                      .where("expiration_date IS NOT NULL") #expiration_dateが存在している（NULLでない）レコードを取得
                                      .where(customer_id: current_customer.id) #customer_idが、現在のログインユーザーのidと一致するレコードを取得
    #賞味期限の近い食材
    @near_best_before_home_foods = HomeFood.where("best_before_date <= ?", Date.today + 2.days)
                                            .where("best_before_date IS NOT NULL")
                                            .where(customer_id: current_customer.id)

    #@near_expiry_home_foods = near_expiry_home_foods.page(params[:page]).per(10) #home_foodsにページネーションを追加
  end

  def mark_as_read

  end

  def destroy
  end
end
