Rails.application.routes.draw do
  resources :database_connection
  resources :queries do
    get :run, on: :collection
  end

  get '/signup', to: 'users#new'
  resources :users, only: [:new, :create]

  root 'queries#index'
end
