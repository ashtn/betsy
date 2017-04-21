Rails.application.routes.draw do


  get 'auth/github/callback', to: 'sessions#create'


  get 'sessions/create'
  get 'sessions/logout'

  get 'reviews/new'
  get 'reviews/create'

  get 'merchants/new'
  get 'merchants/create'

  get 'merchants/index'
  get 'merchants/show'

  get 'categories/create'
  get 'categories/new'

  patch 'item/:id/add_to_cart', to: 'items#add_to_cart', as: 'add_to_cart'

  resources :items

  resources :categories do
    get '/items', to: 'items#index'
  end

  get 'orders/create'
  get 'orders/update'
  get 'orders/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
