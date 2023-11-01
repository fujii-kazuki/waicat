require "test_helper"

class Admin::BreedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_breeds_index_url
    assert_response :success
  end
end
