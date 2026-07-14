require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [ 1400, 1400 ]

  setup do
    Rails.application.routes.default_url_options[:host] = "lvh.me"

    Capybara.app_host = "http://lvh.me"

    Capybara.always_include_port = true
  end
end
