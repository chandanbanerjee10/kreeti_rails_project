Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  #  Users
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get "users/:id/my_posts", to: "users#my_posts", as: 'my_posts' 
  get "users/:id/my_jobs", to: "users#my_jobs", as: 'my_jobs' 

  #  Admin
  get 'admin', to: 'admin#home'   
  get 'admin/job_requests', to: 'admin#job_requests'
  get 'admin/job_show/:id', to: 'admin#job_show', as: 'admin_job_show'
  post 'admin/job_approve/:id', to: 'admin#job_approve', as: 'admin_job_approve'
  delete 'admin/job_reject/:id', to: 'admin#job_reject', as: 'admin_job_reject' 

  # Sessions
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Sector & Types
  scope :admin do
    resources :sectors
    resources :types
  end

  # Jobs
  resources :jobs do
    resources :reviews
  end
  resources :posts
  post 'respond_to_candidate/:id', to: 'posts#respond_to_candidate', as: 'respond_to_candidate'
  delete 'reject_candidate/:id', to: 'posts#reject_candidate', as: 'reject_candidate'
  
  # Chatroom
  get "chatroom", to: "chatroom#index"  
  post 'message', to: 'messages#create'
  mount ActionCable.server, at: '/cable'

  # Google Ouath
  get '/auth/:provider/callback', to: 'sessions#omniauth'
end
