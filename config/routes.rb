Rails.application.routes.draw do
  namespace :users do
    resources :dashboard, only: [:index]
  end

  resources :scores, only: [:index, :new, :create, :update, :destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  resources :scores, only: [:index, :new, :create, :destroy]
  resources :requests, only: [:create, :destroy]
end
