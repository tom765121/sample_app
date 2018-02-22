Rails.application.routes.draw do
	# resource :users

	get '/home', to: 'users#home'
	get '/login', to: 'users#login_page'
	post '/login', to: 'users#login'
	get '/signup', to: 'users#signup_page'
	post '/signup', to: 'users#signup'
	delete '/logout', to: 'users#logout'
	# get '/account/:id', to: 'users#show', as: 'user'
	get '/account', to: 'users#show', as: 'user'
  # get 'users/login'

  # get 'users/signup'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "application#hello"
  root "users#home"
	# match 'home/:id' => 'users#show', via: [:get]
  match "*path", to: redirect('/'), via: :all
end
