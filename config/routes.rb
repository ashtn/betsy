Rails.application.routes.draw do


  get 'auth/github/callback', to: 'sessions#create'


  get 'sessions/create'
  get 'sessions/logout'

  get 'reviews/new'
  get 'reviews/create'

  get '/merchants', to: 'merchants#index', as: 'merchants'
  post '/merchants', to: 'merchants#create'
  get '/merchants/new', to: 'merchants#new', as: 'new_merchant'
  get '/merchants/:id', to: 'merchants#show', as: 'merchant'

  get 'categories/create'
  get 'categories/new'

  resources :items

  resources :categories do
    get '/items', to: 'items#index'
  end

  get 'orders/create'
  get 'orders/update'
  get 'orders/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
