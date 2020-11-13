Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users do
    member do
      get :followings
      get :followers
      get :likes
    end
    collection do
      get :search
    end
  end
  
  resources :posts
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create,:destroy]
end
