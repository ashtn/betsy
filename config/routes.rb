Rails.application.routes.draw do


  get 'auth/github/callback', to: 'sessions#create'


  get 'sessions/create'
  get 'sessions/logout'

<<<<<<< HEAD
  get 'merchants/new'
  get 'merchants/create'
  get 'merchants/index'
  get 'merchants/show'
=======
  get 'reviews/new'
  get 'reviews/create'

  get '/merchants', to: 'merchants#index', as: 'merchants'
  post '/merchants', to: 'merchants#create'
  get '/merchants/new', to: 'merchants#new', as: 'new_merchant'
  get '/merchants/:id', to: 'merchants#show', as: 'merchant'

>>>>>>> c358c5948fc198258dbe5d180d0f5f36803130a0

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
