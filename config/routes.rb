Rails.application.routes.draw do
  resources :functions
  resources :types
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
