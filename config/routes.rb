Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # results routes
  get "results", to: "restaurants#index"

  # temp list routes
  post "temp_list", to: "lists#show"

  resources :calendars, only: [:index]

  # reviews route
  resources :restaurants do
    resources :reviews, only: [:show, :create, :new]
    resources :calendars, only: [:create]
  end

  # lists route
  resources :users do
    resources :lists
  end

  # tags route
  resources :restaurants do
    resources :tags
  end
end
