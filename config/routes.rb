Rails.application.routes.draw do
  resources :database_connection
  resources :queries do
    get :run, on: :collection
  end

  root 'queries#index'
end
