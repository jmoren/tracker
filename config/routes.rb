Tracker::Application.routes.draw do
  get "home/index"
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  get '/notifications/last' => 'notifications#get_unread'
  get '/notifications/update' => 'notifications#update_notification'
  get '/notifications/clean' => 'notifications#destroy_all'
  get '/activities/clean' => 'users#clean_history'
  get '/user/get_notifications' => 'notifications#get_notifications'
  get '/tasks/update_task/dom' => "tasks#update_task"
  post '/tasks/state' => "tasks#move_state"
  post '/collaborator/update' => 'projects#update_collaborator'
  post '/tasks/update_in_place' => 'tasks#update_in_place'
  resources :sessions
  resources :notifications
  resources :users do
    resources :notifications, :only => [:index]
  end

  resources :tasks, :only => [:show, :edit, :update, :destroy] do
    member do
      post 'comments/add' => "tasks#add_comments"
      post 'comments/remove' => "tasks#remove_comments"
    end
  end
  resources :task_lists do
    resources :tasks, :only => [:index,:new, :create]
  end
  resources :projects do
    resources :task_lists
    member do
      get :get_users
      post :add_collaborator
      post 'remove'  => "projects#remove_collaborator"
    end
  end
  resources :activities
  root :to => "home#index"
end

