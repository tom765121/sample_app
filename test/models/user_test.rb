require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: 'Exmaple User', email: 'user@example.com', password: "foobar", password_confirmation: "foobar")
  end

  test "email validation should accept valid addresses" do
  	valid_addresses = %w[[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com tom@..com tom@@.com tom@sdadasd@.com tom@test.test1.-test2..com]]
  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert_not @user.valid?, "#{valid_address.inspect} should be invalid"
  	end
	end

	test "email addresses should be unique" do
		duplicate_user = @user.dup
		@user.email = @user.email.downcase
		@user.save
		duplicate_user.email = @user.email.upcase
		assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as downcase" do
		@user.update_attribute(:email, @user.email.upcase)
		assert_equal @user.email.downcase, @user.reload.email 
	end

	test "password should be present" do
		@user.password = @user.password_confirmation = " " * 6
		assert_not @user.valid?
	end

	test "password should have a minimun size" do
		@user.password = @user.password_confirmation = 'a' * 5
		assert_not @user.valid?
	end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = ""
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "  "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = 'a'*51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = 'a' * 244 + "@example.com"
  	assert_not @user.valid?
  end
end
