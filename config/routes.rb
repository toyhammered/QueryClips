Rails.application.routes.draw do
  get '/signup',     to: 'users#new'
  get '/login',      to: 'sessions#new'
  post '/login',     to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :database_connection
  resources :queries do
    get :run, on: :collection
  end
  resources :users, only: [:new, :create]

  root 'queries#index'
end
