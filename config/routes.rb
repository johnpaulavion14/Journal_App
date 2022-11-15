Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  get 'dasboard/new_task' => 'tasks#new_task', as: 'new_task'
  post 'dasboard/create_new_task' => 'tasks#create_new_task', as: 'create_new_task'
  
  get 'dashboard/index'
  root 'home#index'
  
  get 'dasboard/all_tasks' => 'tasks#all_tasks', as: 'all_tasks'

  post 'categories/:category_id/tasks' => 'tasks#create', as: 'create_task'
  patch 'categories/:category_id/tasks/:id' => 'tasks#update', as: 'update_task'
  delete 'categories/:category_id/tasks/:id' => 'tasks#delete', as: 'delete_task'



  resources :categories do
    resources :tasks
  end
end