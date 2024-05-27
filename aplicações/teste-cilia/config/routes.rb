Rails.application.routes.draw do
  root 'home#index'

  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  devise_scope :customer do
    delete 'customers/cancel', to: 'devise/registrations#cancel', as: nil
  end
  devise_for :admins
  devise_scope :admin do
    delete 'admins/cancel', to: 'devise/registrations#cancel', as: nil
  end

  resources :sales, except: [:destroy] do
    member do
      get :cancel
      get :complete
    end
  end
  resources :products, except: [:destroy] do
    member do
      get :activate
      get :deactivate
    end
  end
  resources :phones
  resources :addresses
  resources :customers, except: [:new, :destroy] do
    member do
      get :activate
      get :deactivate
    end
  end
end
