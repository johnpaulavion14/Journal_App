Rails.application.routes.draw do
  devise_for :users
  get 'dashboard/index'
  root 'home#index'

end