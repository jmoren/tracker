Tracker::Application.routes.draw do
  match 'user/edit' => 'users#edit', :as => :edit_current_user

  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  resources :sessions

  resources :users

  post '/tasks/status' => "tasks#move_status"
  resources :tasks, :only => [:show, :edit, :update, :destroy]
  resources :bugs,  :only => [:show, :update]

  resources :task_lists do
    resources :tasks, :only => [:index,:new, :create]
  end

  resources :bug_lists do
    resources :bugs,  :only => [:index,:new, :create]
  end

  resources :projects do
    resources :bug_lists
    resources :task_lists
    member do
      post :add_collaborator
      post 'remove'  => "projects#remove_collaborator"
      put  :update_collaborator
    end
  end

  root :to => "projects#index"
end

