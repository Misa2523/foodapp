Rails.application.routes.draw do
  namespace :admin do
    get 'genres/index'
    get 'genres/destroy'
    get 'genres/create'
    get 'genres/edit'
    get 'genres/update'

    get 'food_strage_areas/new'
    get 'food_strage_areas/create'
    get 'food_strage_areas/index'
    get 'food_strage_areas/destroy'
    get 'food_strage_areas/edit'
    get 'food_strage_areas/update'

    get 'cooking_posts/index'
    get 'cooking_posts/show'

    get 'customers/posts_index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'

    get 'homes/top'
  end

  namespace :public do
    get 'cooking_posts/new'
    get 'cooking_posts/create'
    get 'cooking_posts/index'
    get 'cooking_posts/search'
    get 'cooking_posts/show'
    get 'cooking_posts/edit'
    get 'cooking_posts/update'
    get 'cooking_posts/destroy'

    get 'customers/index'
    get 'customers/posts_index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'
    get 'customers/check'
    get 'customers/out'

    get 'food_strage_areas/index'

    get 'home_foods/new'
    get 'home_foods/create'
    get 'home_foods/index'
    get 'home_foods/edit'
    get 'home_foods/update'
    get 'home_foods/destroy'

    get 'notifications/index'
    get 'notifications/mark_as_read'
    get 'notifications/destroy'

    get 'homes/top'
    get 'homes/about'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
