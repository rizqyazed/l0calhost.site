require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "authenticated users only" do
    get dashboard_path

    assert_response :redirect

    assert_redirected_to root_path
  end

  test "authenticated users always redirected to dashboard" do
    authenticated_user = users(:one)

    host! "example.com"

    sign_in_as(authenticated_user)

    get root_path

    assert_redirected_to dashboard_path
  end
end
