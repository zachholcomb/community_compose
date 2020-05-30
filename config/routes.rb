Rails.application.routes.draw do
  namespace :users do
    resources :dashboard, only: [:index]
  end

  resources :scores, only: [:index, :new, :create, :update, :destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
