require "application_system_test_case"
require_relative "pages/dashboard_page"
require_relative "pages/login_page"

class UserLogInsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @site = sites(:one)
  end

  # test "user can log in with correct credentials and view their progress" do
  #   dashboard = DashboardPage.new
  #   login = LoginPage.new

  #   login.visit_page

  #   login.fill_log_in(@user.email_address, "password")

  #   login.log_in

  #   assert dashboard.has_basic_info?(@site.title, @site.description)
  # end

  test "user log in with invalid credentials" do
    login = LoginPage.new

    login.visit_page

    login.fill_log_in(@user.email_address, "pas")

    login.log_in

    assert_text "error: try another email address or password."
  end
end
