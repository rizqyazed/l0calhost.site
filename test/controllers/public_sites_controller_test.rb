require "test_helper"

class PublicSitesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_sites_show_url
    assert_response :success
  end
end
