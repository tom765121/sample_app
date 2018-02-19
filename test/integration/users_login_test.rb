require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = users(:michael)
  	# @name = "userlogintest" 
  	# unless user = User.find_by_email("#{@name}@gmail.com")
  	# 	@user = User.create name: "#{@name}", email: "#{@name}@gmail.com", password: "#{@name}pwd", password_confirmation: "#{@name}pwd"
  	# 	@user.save
  	# end
  end

  test "user login success" do
  	get login_path
  	post login_path params: {session: {email: @user.email, password: "password"}}
  	follow_redirect!
  	assert_template 'users/show'
  end

  test "user login fail" do
  	get login_path
  	name = @user.name*2
  	post login_path params: {session: {email: "#{name}@gmail.com", password: "#{name}pwd"}}
  	follow_redirect!
  	assert_template 'sessions/new'
  	assert_not !!flash[:success]
  	assert !!flash[:danger]
  	get login_path
  	assert flash.empty?
  end

  test "current_user show after login" do
  	get login_path
  	# assert_not logged_in?
  	post login_path params: {session: {email: @user.email, password: "password"}}
  	follow_redirect!
  	assert !!flash[:success]
  	assert_template 'users/show'
  	# assert current_user == @user
  	# assert logged_in?
  end

  test "log out the user" do
  	get login_path
  	post login_path params: {session: {email: @user.email, password: "password"}}
  	follow_redirect!
  	assert_template "users/show"
  	# assert logged_in?
  	delete logout_path
  	follow_redirect!
  	assert_template 'static_pages/home'
  	assert_not is_logged_in?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: 1)
    assert_not_empty cookies["remember_token"]
    assert_not_empty cookies["user_id"]
    assert_equal cookies["remember_token"], assigns(:user).remember_token
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: 1)
    assert assigns(:user).remember_digest
    log_in_as(@user, remember_me: 0)
    assert_empty cookies["remember_token"]
    assert_empty cookies["user_id"]
    assert_not assigns(:user).remember_digest
  end

end
