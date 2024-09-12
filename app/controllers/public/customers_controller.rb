class Public::CustomersController < ApplicationController

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def posts_index
    @customer = Customer.find(params[:id])
    @cooking_posts = @customer.cooking_posts  #会員に紐づく料理投稿を取得（idで指定された会員の投稿のみ表示するため）
    
    
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
  end

  def check
  end

  def out
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :telephone_number, :email, :is_active)
  end

end
