Rails.application.routes.draw do
  resources :categories
  devise_for :users
  get 'dashboard/index'
  root 'home#index'

end