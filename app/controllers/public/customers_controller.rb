class Public::CustomersController < ApplicationController

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def posts_index
    @customer = Customer.find(params[:id])
    @cooking_posts = @customer.cooking_posts  #会員に紐づく料理投稿を取得（idで指定された会員の投稿のみ表示するため定義）

    @customers = Customer.all.page(params[:page]).per(10) #ページネーション用に定義
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

end
