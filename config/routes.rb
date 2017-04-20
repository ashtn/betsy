Rails.application.routes.draw do
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

  get 'items/index'

  get 'items/new'

  get 'items/create'

  get 'items/edit'

  get 'items/update'

  get 'items/show'

  get 'orders/create'

  get 'orders/update'

  get 'orders/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
