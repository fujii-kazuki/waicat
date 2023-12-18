require "test_helper"

class Public::BookmarksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_bookmarks_index_url
    assert_response :success
  end
end
