Rails.application.routes.draw do
  get 'users/show'

  root to: 'pages#home'

  # get '/users/sign_out' => 'devise/sessions#destroy'

  get 'my_products', to: 'products#my_products'
  get '/bookings/:id/accept', to: 'bookings#accept', as: 'accept_booking'
  get '/bookings/:id/reject', to: 'bookings#reject', as: 'reject_booking'


  devise_for :users
  resources :products do
    resources :bookings, only: %i[new create destroy]

    collection do
      get :search
    end

    member do
      get :reviews
    end

    resources :bookings, only: %i[new create destroy]
  end

  resources :bookings, except: %i[new index create] do
    resources :reviews, only: %i[new create]
  end

  resources :reviews, except: %i[new create]

  get '/bookings', to: 'bookings#index'

  get '/error', to: 'errors#not_found'

  get "*path", to: redirect("/error")
end
