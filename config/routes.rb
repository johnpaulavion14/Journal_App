Rails.application.routes.draw do
  devise_for :users
  get 'dashboard/index'
  root 'home#index'

  resources :categories do
    resources :tasks
  end
end