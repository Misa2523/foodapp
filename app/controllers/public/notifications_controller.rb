class Public::NotificationsController < ApplicationController

  #ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_customer!

  #application_controller.rbで定義したメソッドを実行（ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限）すべてのアクションに対し
  before_action :restricted_guest_user

  def index
    #期限が2日以内の食材（消費期限）
    @near_expiry_home_foods = HomeFood.where("expiration_date <= ?", Date.today + 2.days)
                                      .where("expiration_date IS NOT NULL")
                                      .where(customer_id: current_customer.id)
    #期限が2日以内の食材（消費期限）
    @near_best_before_home_foods = HomeFood.where("best_before_date <= ?", Date.today + 2.days)
                                            .where("best_before_date IS NOT NULL")
                                            .where(customer_id: current_customer.id)
    #期限が切れいている食材（消費期限が過ぎたもの）
    @expired_home_foods = HomeFood.where("expiration_date <= ?", Date.today)
                                  .where("expiration_date IS NOT NULL")
                                  .where(customer_id: current_customer.id)
    #期限が切れいている食材（賞味期限が過ぎたもの）
    @expired_best_before_home_foods = HomeFood.where("best_before_date <= ?", Date.today)
                                  .where("best_before_date IS NOT NULL")
                                  .where(customer_id: current_customer.id)



    #@remaining_days_expiration = (home_food.expiration_date - Date.today).to_i     #消費期限までの残り日数
    #@remaining_days_best_before = home_food.best_before_date - Date.today   #賞味期限までの残り日数

    #@near_expiry_home_foods = near_expiry_home_foods.page(params[:page]).per(10) #home_foodsにページネーションを追加
  end

  def mark_as_read

  end

  def destroy
  end
end
