Rails.application.routes.draw do

  resources :users

  get "/index", to: 'static_pages#index'

  # get "/home", to: 'static_pages#home'

  get "/help", to: 'static_pages#help'

  get "/about", to: "static_pages#about"

  get '/signup', to: "users#new"

  post '/signup', to: "users#create"

  # get '/login', to: "users#login"

  delete	'/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
end
