Rails.application.routes.draw do
  root to: 'sessions#new'
  
  namespace :users do
    resources :dashboard, only: [:index]
  end

  resources :scores, only: [:index, :new, :create, :destroy]
  resources :requests, only: [:create, :destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
