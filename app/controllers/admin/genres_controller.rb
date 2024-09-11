class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "新しいジャンルを登録しました"
      redirect_to admin_genres_path
    else
      flash[:notice] = "ジャンルの登録ができませんでした"
      redirect_to admin_genres_path
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre.destroy
      flash[:notice] = "ジャンルを削除しました"
      redirect_to admin_genres_path
    else
      flash[:notice] = "ジャンルの編集ができませんでした"
      redirect_to admin_genres_path
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルが更新されました"
      redirect_to admin_genres_path
    else
      @genre = Genre.find(params[:id]) #renderでeditページを描くため、editで使う変数をこのアクション内で再定義
      flash[:notice] = "入力項目を正しく入力してください"
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
