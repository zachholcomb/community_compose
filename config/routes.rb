Rails.application.routes.draw do
  namespace :users do
    resources :dashboard, only: [:index]
  end

  resources :scores, only: [:index]
end
