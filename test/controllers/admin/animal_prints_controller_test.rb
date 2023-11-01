require "test_helper"

class Admin::AnimalPrintsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_animal_prints_index_url
    assert_response :success
  end
end
