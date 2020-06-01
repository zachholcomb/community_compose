Rails.application.routes.draw do
  root to: 'sessions#new'

  namespace :users do
    resources :dashboard, only: [:index]
    resources :explore, only: [:index]
    get '/location/:id/edit', to: 'location#edit', as: :edit_location
    patch '/location/:id', to: 'location#update', as: :location
    get '/profile/:id/edit', to: 'profile#edit', as: :edit_profile
    patch '/profile/:id', to: 'profile#update', as: :profile
  end

  resources :scores, only: [:index, :new, :create, :update, :destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  resources :scores, only: [:index, :new, :create, :destroy]
  resources :requests, only: [:create, :destroy]

  resources :users, only: [:show, :edit, :update]
end
