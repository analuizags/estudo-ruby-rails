Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  devise_for :admins
  resources :sales, except: [:destroy] do
    member do
      get :cancel
      get :complete
    end
  end
  resources :products
  resources :phones
  resources :addresses
  resources :customers, except: [:new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
