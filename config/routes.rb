Rails.application.routes.draw do
	resource :users

	get '/home', to: 'users#home'
	get '/login', to: 'users#login_page'
	post '/login', to: 'users#login'
	get '/signup', to: 'users#signup_page'
	post '/signup', to: 'users#signup'
	delete '/logout', to: 'users#logout'

  # get 'users/login'

  # get 'users/signup'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "application#hello"
  root "users#home"
  
  match "*path", to: redirect('/'), via: :all
end
