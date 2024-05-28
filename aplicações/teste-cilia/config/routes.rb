Rails.application.routes.draw do
  root 'home#index'

  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  devise_scope :customer do
    delete 'customers/cancel', to: 'devise/registrations#cancel', as: nil
  end

  devise_for :admins, skip: [:registrations]
  as :admin do
    get 'admins/edit' => 'devise/registrations#edit', as: 'edit_admin_registration'
    put 'admins' => 'devise/registrations#update', as: 'admin_registration'
  end
  devise_scope :admin do
    delete 'admins/cancel', to: 'devise/registrations#cancel', as: nil
  end
  
  resources :sales, except: [:destroy] do
    collection do
      get :index_admin, path: 'admin/index'
    end
    member do
      get :cancel
      get :complete
      get :show_admin, path: 'admin/show'
      get :cancel_admin, path: 'admin/cancel'
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
