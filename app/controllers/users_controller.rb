class UsersController < ApplicationController

	def home
	end

	def login_page
	end

  def login
  	user = User.find_by_email(login_params[:email])
		if user && user.verify_password?(login_params[:password])
			remember_session(user)
			login_params[:remember_me] == '1' ? remember_cookies(user) : forget_cookies(user)
  		flash[:success] = "successful login"
			redirect_to root_path
		else
  		flash.now[:danger] = "something is wrong"
  		render 'users/login_page'
		end
  end

  def signup_page
  end

  def signup
  	user = User.create name: signup_params[:name], email: signup_params[:email], password: signup_params[:password], password_confirmation: signup_params[:password_confirmation]
  	if user.valid?
  		remember_session(user)
  		flash[:success] = "successful login"
  		redirect_to root_path
  	else
  		flash.now[:danger] = "something is wrong"
  		render 'users/signup_page'
  	end
  end

  def logout
  	current_user_logout
  	redirect_to root_path
  end

  private
  def login_params
  	params.require(:login_info).permit(:email, :password, :remember_me)
  end

  def signup_params
  	params.require(:signup_info).permit(:name, :email, :password, :password_confirmation)
  end 
end
