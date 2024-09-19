class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!  #ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）

  before_action :restricted_guest_user #application_controller.rbで定義したメソッドを実行（ゲストユーザーによるURL直打ちでの、ページ遷移と処理を制限）全てのアクションに対し
  before_action :cancel_membership, only: [:posts_index] #private内で定義したメソッドを実行（退会している会員の投稿一覧ページは閲覧不可にする）

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def posts_index
    @customer = Customer.find(params[:id])
    @cooking_posts = @customer.cooking_posts.page(params[:page]).per(10)  #会員に紐づく料理投稿を取得（idで指定された会員の投稿のみ表示するため定義）
  end

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "会員情報が更新されました"
      redirect_to customers_my_page_path
    else
      flash[:notice] = "入力項目を正しく入力してください"
      render :edit
    end
  end

  def check
  end

  def out
    @customer = current_customer
    @customer.update(is_active: false) #is_activeカラムをfalseに更新（会員ステータスを退会状態に更新）。実際にはデータベース上の会員レコードは削除されない（論理削除）。
    reset_session #セッション情報をリセット（個人情報やアクション履歴の情報をリセット）
    flash[:notice] = "退会しました"
    redirect_to new_customer_registration_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :telephone_number, :email, :is_active)
  end

  #退会している会員の情報は閲覧不可にする（特定会員の投稿一覧ページ、投稿詳細ページに反映させる：URL直打ち対策）
  def cancel_membership
    @customer = Customer.find(params[:id]) #URLの会員情報を取得
    if @customer.is_active == false #会員ステータスがfalse(退会ユーザー)だったら
      flash[:notice] = "ご指定の会員の投稿は閲覧できません"
      redirect_to cooking_posts_path
    end
  end

end
