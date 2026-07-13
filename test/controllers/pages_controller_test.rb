require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    host! "example.com"
    get root_path
    assert_response :success
  end
end
