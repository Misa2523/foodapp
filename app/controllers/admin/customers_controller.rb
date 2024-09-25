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
      # 他のユーザーで同じメールアドレスまたは電話番号が存在しているか確認し、重複してたらそれぞれの変数に代入（where.not(id: @customer.id) ==> 現在のユーザー以外で）
      email_exists = Customer.where.not(id: @customer.id).exists?(email: customer_params[:email])
      telephone_exists = Customer.where.not(id: @customer.id).exists?(telephone_number: customer_params[:telephone_number])

      if email_exists && telephone_exists # メールアドレスと電話番号の両方が重複してたら
        flash[:notice] = "このメールアドレスと電話番号は既に使用されています"

      elsif email_exists # メールアドレスのみ重複してたら
        flash[:notice] = "このメールアドレスは既に使用されています"

      elsif telephone_exists # 電話番号のみ重複してたら
        flash[:notice] = "この電話番号は既に使用されています"

      else
        flash[:notice] = "入力項目を正しく入力してください"
      end
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :telephone_number, :email, :is_active)
  end

end
