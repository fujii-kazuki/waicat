require "test_helper"

class Admin::ChatroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_chatrooms_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_chatrooms_show_url
    assert_response :success
  end
end
