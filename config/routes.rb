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

  resources :items

  resources :categories do
    get '/items', to: 'items#index'
  end

  resources :orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
