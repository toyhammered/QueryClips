Rails.application.routes.draw do
  get 'landing/index'

  get '/signup',     to: 'users#new'
  get '/login',      to: 'sessions#new'
  post '/login',     to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :database_connection
  resources :queries
  resources :users, only: [:new, :create]

  root 'landing#index'
end
