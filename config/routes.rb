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

  devise_scope :customer do   #ゲストログイン機能
    post 'customer/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    resources :cooking_posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      collection do #オリジナルのアクションに対する設定
        get 'search'
      end
    end
    resources :food_strage_areas, only: [:index]
    resources :home_foods, only: [:new, :create, :index, :edit, :update, :destroy]

    get '/notifications/:id/mark_as_read' => 'notifications#mark_as_read', as: "mark_as_read_notifications" #URIパターンを設計書通りに修正
    resources :notifications, only: [:index, :destroy]

    get '/customers' => 'customers#index'
    get '/customers/my_page' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    patch '/customers/information' => 'customers#update'
    get '/customers/:id/cooking_posts' => 'customers#posts_index', as: "posts_index_customers"
    get '/customers/check' => 'customers#check'
    patch '/customers/out' => 'customers#out'
  end

  #管理者側の設定
  get 'admin', to: 'admin/homes#top'
  namespace :admin do
    resources :genres, only: [:index, :destroy, :create, :edit, :update]
    resources :food_strage_areas, only: [:new, :create, :index, :destroy, :edit, :update]
    resources :cooking_posts, only: [:index, :show]

    get 'customers/:id/cooking_posts' => 'customers#posts_index', as: "customers_posts_index"
    resources :customers, only: [:show, :edit, :update]
  end

end
