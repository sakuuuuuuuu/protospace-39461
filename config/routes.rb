Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: :create  
      # resources :prototypes do
    
    # resources :comments, only: :create 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  end
  resources :users, only: :show
#  resources :users, only: [:index, :new, :create, :destroy, :edit]

end
