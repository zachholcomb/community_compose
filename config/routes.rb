Rails.application.routes.draw do
  namespace :users do
    resources :dashboard, only: [:index]
  end
end
