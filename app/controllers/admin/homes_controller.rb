class Admin::HomesController < ApplicationController
  
  before_action :autenticate_admin! #adminとしてログインしている場合のみアクセスする
  
  def top
  end
end
