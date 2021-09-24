Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # results routes
  get "results", to: "restaurants#index"

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
  resources :tags
end
