Rails.application.routes.draw do
  root to: 'pages#home'

  # users routes
  devise_for :users
  get "users/:id/map", to: "users#mapping", as: :user_map

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # results routes
  get "results", to: "restaurants#index"

  # temp list routes
  post "temp_list", to: "lists#show"

  # restaurant routes
  get "restaurants/:id", to: "restaurants#show", as: :restaurant

  # reviews route
  resources :restaurants do
    resources :reviews, only: [:show, :create, :new]
  end

  # lists route
  resources :users do
    resources :lists
  end

  # tags route
  resources :restaurants do
    resources :tags
  end

  # explores route
  resources :restaurants do
    resources :explores
  end
end
