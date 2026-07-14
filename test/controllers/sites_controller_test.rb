require "test_helper"

class SitesControllerTest < ActionDispatch::IntegrationTest
  test "layout selection works" do
    user = users(:one)

    get root_url(subdomain: user.username)

    assert_response :success

    assert_select "body[data-layout='center']"
  end

  test "theme selection works" do
    user = users(:one)

    get root_url(subdomain: user.username)

    assert_response :success

    assert_select "body.theme-classic"
  end
end
