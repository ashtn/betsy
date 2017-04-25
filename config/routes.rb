Rails.application.routes.draw do
  root 'items#index'

  # get '/login', to: 'sessions#login_form'
  # post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'
  get '/auth/github/callback', to: 'sessions#create'

  get '/merchants', to: 'merchants#index', as: 'merchants'
  post '/merchants', to: 'merchants#create'
  get '/merchants/new', to: 'merchants#new', as: 'new_merchant'
  get '/merchants/:id', to: 'merchants#show', as: 'merchant'

  post 'items/:id/add_to_cart', to: 'items#add_to_cart', as: 'add_to_cart'
  get '/cart/:session_id', to: 'items#add_to_cart', as: 'cart'


  resources :items do

    resources :reviews, except: [:index, :show]
  end

  post "/items/:id", to: "reviews#create"

  resources :categories, except: [:edit, :update, :destroy] do
    get '/items', to: 'items#index'
  end

  resources :orders
  get '/orders/:id/pay', to: 'orders#pay', as: 'pay'
  post '/orders/:id/pay', to: 'orders#paid', as: 'paid'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
