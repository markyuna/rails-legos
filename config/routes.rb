Rails.application.routes.draw do
  devise_for :users
  resources :products, only: %i[destroy]
  root to: 'pages#home'

  get '/users/sign_out' => 'devise/sessions#destroy'

  get 'my_products', to: 'products#my_products'

  resources :products do
    resources :bookings, only: %i[new create]

    collection do
      get :search
    end

    member do
      get :reviews
    end

    resources :bookings, only: [ :new, :create ]
  end

  resources :bookings, except: [ :new, :index, :create ] do
    resources :reviews, only: [ :new, :create ]
  end

  resources :reviews, except: [ :new, :create ]

  get '/bookings', to: 'bookings#index'

  get '/error', to: 'errors#not_found'

  get "*path", to: redirect("/error")
end
