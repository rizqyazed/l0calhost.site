require "test_helper"

class PublicSitesControllerTest < ActionDispatch::IntegrationTest
    test "accessing user's public site" do
      get root_url(subdomain: "one")

      assert_response :success
    end

    test "safely redirects to 404 if subdomain not found or invalid" do
      get root_url(subdomain: "four")

      assert_response :not_found
    end
end
