require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post signup_path, params: {user: { name: '', email: 'testtest1@gmail.com', password: "testtest1pwd", password_confirmation: "testtest1pwd"} }
  	end
  	assert_template 'users/new'
  	assert_select 'div.alert', "The form contains 2 errors."
  	assert_not is_logged_in?

  end

  test "invalid signup information or wrong flash" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		# test case will not really create user so it can be reused
	  	#	loop do
	  	#		name = Time.now.to_s.split('').shuffle[0..(5+rand(3))].join
	  	#		break unless User.find_by_name(name)
			# end
			name = "test123" 
  		post signup_path params: {user: {name: name, email: "#{name}@gmail.com", password: "#{name}pwd", password_confirmation: "#{name}pwd"} }
  	end
	  	# user = User.find_by_email("#{name}@gmail.com")
	  	# assert !!user
  	follow_redirect!
  	assert_template 'users/show'
  	assert_not flash[:success] != "Welcome to the Sample App"
  	assert is_logged_in?
  end
end
