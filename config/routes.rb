Rails.application.routes.draw do
  # Shortcut Routes
  get 'landing/index'
  get '/signup',     to: 'users#new'
  get '/login',      to: 'sessions#new'
  post '/login',     to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # Resources, alphabetized
  resources :database_connection
  resources :queries do
    get '/email', to: 'queries#email'
  end
  resources :users
  resources :visualizations

  # Root
  root 'landing#index'
end
