require "application_system_test_case"
require_relative "pages/dashboard_page"
require_relative "pages/login_page"

class PublishSitesTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @site = sites(:one)

    login = LoginPage.new
    login.visit_page
    login.fill_log_in(@user.email_address, "password")
    login.log_in
  end

  test "user can publish changes and visit their live site" do
    dashboard = DashboardPage.new

    dashboard.fill_basic_info("updated title", @site.description)

    dashboard.publish_site

    assert dashboard.has_published_message?

    dashboard.view_live_site(@user.username)

    assert_text "updated title"
  end
end
