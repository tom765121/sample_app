require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new name: "tomtom", email: "tom@gmail.com", password: "tompwd", password_confirmation: "tompwd"
  end

 	test "name should be present" do
 		@user.name = ""
 		assert_not @user.valid?
 	end

 	test "name size should shorter than 50" do
 		@user.name = 'a'*51
 		assert_not @user.valid?
 	end

 	test "name size should longer than 5" do
 		@user.name = 'a'
 		assert_not @user.valid?
 	end

 	test "email should be presence" do
 		@user.email = ""
 		assert_not @user.valid?
 	end

 	test "email size should be shorter than 250" do
 		@user.email = 'a'*251
 		assert_not @user.valid?
 	end

 	test "email size should be longer than 5" do
 		@user.email = 'a'
 		assert_not @user.valid?
 	end

 	test "email format should be correct" do
 		@user.email = "aaaa.com"
 		assert_not @user.valid?
 		@user.email = "aaaa@google.com"
 		assert @user.valid?
 		@user.email = "aaaa@....com"
 		assert_not @user.valid?
 		@user.email = "asd+-ac3424c2@+3424fsdfsdf.sdaddadad"
 		assert_not @user.valid?
 	end

 	test "email should be unique and do not care case-nsitive" do
 		@user.email = 'asdasdasd'.downcase
 		user2 = @user.dup
 		user2.email = user2.email.upcase
 		assert_not user2.valid?
 	end

 	test "password should always be presence" do
 		@user.password = @user.password_confirmation = ""
 		assert_not @user.valid?
 	end

 	test "password should be shorter than 5" do
 		@user.password = @user.password_confirmation = 'a'*4
 		assert_not @user.valid?
 	end

end
