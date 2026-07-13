require "application_system_test_case"
require_relative "pages/home_page"
require_relative "pages/dashboard_page"

class CreatingSitesTest < ApplicationSystemTestCase
  test "a new visitor can create an account" do
    home = HomePage.new
    dashboard = DashboardPage.new

    home.visit_page

    home.fill_sign_in("three", "three@example.com", "password")

    home.sign_in

    assert_current_path dashboard_path

    dashboard.view_live_site("three")

    assert_current_path root_url(subdomain: "three", port: Capybara.current_session.server.port)
  end

  test "error handling when user enters wrong credentials" do
    home = HomePage.new

    home.visit_page

    home.fill_sign_in("th", "three@example.com", "password")

    home.sign_in

    assert_text "error:"
  end
end
