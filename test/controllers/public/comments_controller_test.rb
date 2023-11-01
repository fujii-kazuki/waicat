require "test_helper"

class Public::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_comments_index_url
    assert_response :success
  end
end
