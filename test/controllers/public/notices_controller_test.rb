require "test_helper"

class Public::NoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_notices_index_url
    assert_response :success
  end
end
