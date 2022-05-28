Rails.application.routes.draw do
  devise_for :users
  mount Blazer::Engine, at: 'blazer'
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :offers, only: %i[index show] do
    resources :reviews, only: [:create]
    resources :bookings, only: %i[new create]
    resources :likes, only: [:create, :destroy]
  end

  resources :bookings, only: [:destroy]
end
