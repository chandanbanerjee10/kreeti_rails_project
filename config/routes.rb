Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "pages#home"
   get "about", to: "pages#about"
   get 'signup', to: 'users#new'
   resources :users, except: [:new]

   get "login", to: "sessions#new"
   post "login", to: "sessions#create"
   delete "logout", to: "sessions#destroy"

  #  Posts
    resources :posts

  #  Admin
    get "admin/sectors/new", to: "sectors#new"
    get "admin/sectors", to: "sectors#index"
    get "admin/sectors/:id", to: "sectors#show"
    post "admin/sectors", to: "sectors#create"
    # namespace :admin do
    #   resources :sectors
    # end
end
