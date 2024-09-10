class Public::CookingPostsController < ApplicationController

  def new
    @cooking_post = CookingPost.new
  end

  def create
    cooking_post = CookingPost.new(cooking_post_params)
    cooking_post.customer_id = current_customer.id

    if cooking_post.save
      flash[:notice] = "新しい料理を投稿しました"
      redirect_to cooking_post_path(cooking_post.id)
    else
      cooking_post = CookingPost.new
      flash[:notice] = "料理の投稿ができませんでした"
      render :new
    end
  end

  def index
  end

  def search
  end

  def show
    @cooking_post = CookingPost.find(params[:id])
  end

  def edit
    @cooking_post = CookingPost.find(params[:id])
  end

  def update
    cooking_post = CookingPost.find(params[:id])
    if cooking_post.update(cooking_post_params)
      flash[:notice] = "料理情報が更新されました"
      redirect_to cooking_post_path(cooking_post.id)
    else
      cooking_post = CookingPost.find(params[:id])
      flash[:notice] = "料理の更新ができませんでした"
      render :edit
    end
  end

  def destroy
  end

  private

  def cooking_post_params
    params.require(:cooking_post).permit(:cooking_post_image, :customer_id, :name, :introduction)
  end

end
