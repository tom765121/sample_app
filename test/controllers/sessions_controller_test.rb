require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

	def setup
		@name = 'sessiontest1'
		unless @user = User.find_by_email("#{@name}@gmail.com")
			@user = User.new name: "#{@name}", email: "#{@name}@gmail.com", password: "#{@name}pwd", password_confirmation: "#{@name}pwd"
			@user.save
		end
	end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should post create" do
  	post login_path params: {session: {email: "#{@name}@gmail.com", password: "#{@name}pwd"}}
  	assert !!flash[:success]
  	follow_redirect!
  	assert_template 'users/show'
  end

  test "should destroy user" do
  	delete logout_path
  	follow_redirect!
  	assert_template 'static_pages/home'
  end

end
