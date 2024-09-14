class Admin::CustomersController < ApplicationController

  #管理者ログイン前ユーザーによるURL直打ちでの、ページ遷移と処理を制限（全てのアクションに対し）
  before_action :authenticate_admin!

  def posts_index
    @customer = Customer.find(params[:id])
    @cooking_posts = @customer.cooking_posts #会員に紐づく料理投稿を取得（idで指定された会員の投稿のみ表示するため定義）

    @customers = Customer.all.page(params[:page]).per(10) #ページネーション用に定義
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報が更新されました"
      redirect_to admin_customer_path(@customer)
    else
      flash[:notice] = "入力項目を正しく入力してください"
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :telephone_number, :email, :is_active)
  end

end
