require "test_helper"

class Public::ChatroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_chatrooms_index_url
    assert_response :success
  end

  test "should get show" do
    get public_chatrooms_show_url
    assert_response :success
  end
end
