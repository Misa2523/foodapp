class Public::CustomersController < ApplicationController

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def posts_index
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
