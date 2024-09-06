Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #会員側の設定
  root 'public/homes#top'
  get 'about', to: 'public/homes#about'
  scope module: :public do
    resources :cooking_posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      collection do #オリジナルのアクションに対する設定
        get 'search'
      end
    end
    resources :customers, only: [:index, :show, :edit, :update] do
      collection do #オリジナルのアクションに対する設定
        get 'posts_index'
        get 'check'
        get 'out'
      end
    end
    resources :food_strage_areas, only: [:index]
    resources :home_foods, only: [:new, :create, :index, :edit, :update, :destroy]
    resources :notifications, only: [:index, :destroy] do
      collection do #オリジナルのアクションに対する設定
        get 'mark_as_read'
      end
    end
  end

  #管理者側の設定
  get 'admin', to: 'admin/homes#top'
  namespace :admin do
    resources :genres, only: [:index, :destroy, :create, :edit, :update]
    resources :food_strage_areas, only: [:new, :create, :index, :destroy, :edit, :update]
    resources :cooking_posts, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update] do
      collection do #オリジナルのアクションに対する設定
        get 'posts_index'
      end
    end
  end

end
