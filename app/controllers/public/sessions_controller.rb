class Public::SessionsController < Devise::SessionsController

  before_action :reject_customer, only: [:create] #createアクション実行前にこのメソッドを実行

  def after_sign_in_path_for(resource)
    customers_my_page_path #サインイン後マイページへ遷移
  end

  def after_sign_out_path_for(resource_or_scope)
    about_path #サインアウト後Aboutページへ遷移
  end

  def guest_sign_in
    customer = Customer.guest
    sign_in customer  #ゲストユーザーをログイン状態にする
    redirect_to root_path, notice: "ゲストユーザーでログインしました。"
  end

  protected

  # 会員の論理削除のためのメソッド（退会後は同じアカウントでは利用できない）
  def reject_customer
    @customer = Customer.find_by(email: params[:customer][:email]) #Customerモデルから入力されたemailを検索し、該当する1件を取得
    if @customer #@customerが存在したら
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_active == false) #特定したアカウントとログイン画面で入力されたパスワードが一致している、かつ、その会員が退会状態だったら
        flash[:notice] = "退会済みです。再度会員登録をしてご利用ください。"
        redirect_to new_customer_registration_path and return
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end

end
