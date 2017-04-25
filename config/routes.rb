Rails.application.routes.draw do
  get 'payments/new'

  root 'items#root'
  get '/items', to: 'items#index'
  get "/items/cart", to: "items#show_cart", as: "cart"
  patch '/item/cart/update_cart/:id', to: 'items#update_cart', as: "order_item"
  patch '/item/:id/add_to_cart', to: 'items#add_to_cart', as: 'add_to_cart'
  delete 'item/:id/delete', to: 'item#remove_from_cart', as: "delete_order_item"

  # get '/login', to: 'sessions#login_form'
  # post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'
  get '/auth/github/callback', to: 'sessions#create'

  get '/merchants', to: 'merchants#index', as: 'merchants'
  post '/merchants', to: 'merchants#create'
  get '/merchants/new', to: 'merchants#new', as: 'new_merchant'
  get '/merchants/:id', to: 'merchants#show', as: 'merchant'
  get '/merchants/items/:id', to: 'merchants#merchant_items', as: 'merchant_items'
  get '/merchants/:id/:status', to: 'merchants#order_by_status', as: 'order_by_status'



  resources :items do

    resources :reviews, except: [:index, :show]
  end


  post "/items/:id", to: "reviews#create"
  delete "item/remove_from_cart", to: 'item#remove/from/cart', as: "remove_from_cart"


  resources :categories, except: [:edit, :update, :destroy] do
    get '/items', to: 'items#index'
  end

  resources :orders
  get '/orders/:id/pay', to: 'orders#pay', as: 'pay'
  post '/orders/:id/pay', to: 'orders#paid', as: 'paid'

  get '/payments/:id/confirmation', to: 'payments#confirmation', as: 'confirmation'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
