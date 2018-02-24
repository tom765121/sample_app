require 'test_helper'

class AlarmsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get alarms_new_url
    assert_response :success
  end

end
