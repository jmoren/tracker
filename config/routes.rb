Tracker::Application.routes.draw do
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  post '/tasks/state' => "tasks#move_state"
  post '/collaborator/update' => 'projects#update_collaborator'
  post '/tasks/update_in_place' => 'tasks#update_in_place'
  resources :sessions
  resources :users
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
  root :to => "projects#index"
end

