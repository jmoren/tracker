Tracker::Application.routes.draw do
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
  end

  root :to => "projects#index"
end

