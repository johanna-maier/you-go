Rails.application.routes.draw do
  devise_for :users
  mount Blazer::Engine, at: 'blazer'
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end