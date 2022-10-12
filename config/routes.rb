Rails.application.routes.draw do
  devise_for :users
  get 'dashboard/index'
  root 'home#index'

  patch 'categories/:category_id/tasks/:id' => 'tasks#update', as: 'update_task'
  delete 'categories/:category_id/tasks/:id' => 'tasks#delete', as: 'delete_task'

  resources :categories do
    resources :tasks
  end
end