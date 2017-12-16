require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

	# setup is a specail fuction. it will auto run.
	def setup
		@base_title = "Ruby on Rails Tutorial Sample App"
	end

	test "should get root" do
		get root_url
		assert_response :success
		assert_select "title", "Home | #{@base_title}"
	end
  test "should get Home" do
    get static_pages_Home_url
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get Help" do
    get static_pages_Help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get About" do
		get static_pages_About_url
		assert_response :success
		assert_select "title", "About | #{@base_title}"
  end

  test "should get Contact" do
		get static_pages_Contact_url
		assert_response :success
		assert_select "title", "Contact | #{@base_title}"
  end

end
