Rails.application.routes.draw do


  get 'auth/github/callback', to: 'sessions#create'


  get 'sessions/create'
  get 'sessions/logout'

  get 'merchants/new'
  get 'merchants/create'
  get 'merchants/index'
  get 'merchants/show'

  patch 'item/:id/add_to_cart', to: 'items#add_to_cart', as: 'add_to_cart'

  resources :items do
    resources :reviews, only: [:new, :create]
  end

  resources :categories, except: [:edit, :update, :destroy] do
    get '/items', to: 'items#index'
  end

  resources :orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
