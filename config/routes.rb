Rails.application.routes.draw do
  devise_for :users
  mount Blazer::Engine, at: 'blazer'
  root to: 'pages#home'
  # get 'dashboard', to: 'pages#dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :offers, only: %i[index show] do
    resources :reviews, only: [:create]
  end

  resources :dashboard, only: [:index] do
    resources :user, only: [:update] # edit
  end
end
