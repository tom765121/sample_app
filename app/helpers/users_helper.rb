module UsersHelper
	def remember_session(user)
		session[:user_id] = user.id
	end

	def remember_cookies(user)
		user.generate_authentication_token
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:authentication_token] = user.authentication_token
	end

	def forget_cookies(user)
		cookies.delete(:user_id)
		cookies.delete(:authentication_token)
		user.remove_authentication_token
	end

	def current_user
		# @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
		if user_id = session[:user_id]
			@current_user ||= User.find_by(id: user_id)
		elsif user_id = cookies.signed[:user_id]
			@current_user ||= User.find_by(id: user_id)
			if @current_user && @current_user.authenticate?(cookies[:authentication_token])
				remember_session(@current_user)
			else
				@current_user = nil
			end
		end
		return @current_user
	end

	def logged_in?
		return !!current_user
	end

	def current_user_page?
		# @
	end

	def current_user_logout
		forget_cookies(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

end
