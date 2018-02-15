class SessionsController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	if (user = User.find_by_email(session_params[:email])) && !!user.authenticate(session_params[:password])
  		flash[:success] = "it is good"
  		log_in user
  		redirect_to user
  	else
  		# this is for redirect
  		flash[:danger] = 'Invalid email/password combination' 
  		redirect_to login_path

  		# # flash.now is for render
  		# flash.now[:danger] = 'Invalid email/password combination' 
  		# render 'new'
  	end
  end

  def destroy
  	log_out
  	redirect_to root_path
  end

  private
  	def session_params
  		params.require(:session).permit(:email, :password)
  	end

end
