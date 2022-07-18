Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  get "about", to: "pages#about"

  #  Users
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  post 'users/respond_to_candidate/:id', to: 'users#respond_to_candidate', as: 'respond_to_candidate'
  #  Admin
  get 'admin', to: 'admin#home'   
  get 'admin/job_requests', to: 'admin#job_requests'
  get 'admin/job_show/:id', to: 'admin#job_show', as: 'admin_job_show'
  post 'admin/job_approve/:id', to: 'admin#job_approve', as: 'admin_job_approve'
  post 'admin/job_reject/:id', to: 'admin#job_reject', as: 'admin_job_reject'


  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Posts
  


  # Sector & Types
  scope :admin do
    resources :sectors
    resources :types
  end

  # Jobs
  resources :jobs do
    resources :reviews
    resources :posts
  end
  get "users/:id/my_posts", to: "posts#my_posts"
  # Chatroom
  get "chatroom", to: "chatroom#index"  
  post 'message', to: 'messages#create'
  mount ActionCable.server, at: '/cable'

  # Google Ouath
  get '/auth/:provider/callback', to: 'sessions#omniauth'
end
